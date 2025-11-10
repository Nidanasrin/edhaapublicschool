import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class Classwise extends StatefulWidget {
  const Classwise({super.key});

  @override
  State<Classwise> createState() => _ClasswiseState();
}

class _ClasswiseState extends State<Classwise> {
    final formkey = GlobalKey<FormState>();
    String? selectedValue;
    final announcementController = TextEditingController();
    final List<String> items = ["Text", "Voice"];
    String? selectedItem;
    bool isUploading = false;
    List<String> list = [
      "NURSERY",
      "LKG",
      "UKG",
     "GRADE-1",
      "GRADE-2",
      "GRADE-3",
      "GRADE-4",
      "GRADE-5",
      "GRADE-6",
      "GRADE-7",
      "DAY CARE",
      "GRADE-7 STATE SYLLABUS",
      "GRADE-8 STATE SYLLABUS",

    ];

    final record = AudioRecorder();
    final audioPlayer =AudioPlayer();
    String? filePath;

    Future<bool> requestPermissions() async {
      var mic = await Permission.microphone.request();
      var storage = await Permission.storage.request();
      return mic.isGranted && storage.isGranted;
    }


    Future<void> startRecording()async{
      if (await requestPermissions()) {
        final dir = await getApplicationDocumentsDirectory();
        final path =
            '${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
        filePath = path;
        debugPrint('Recording started: $path');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Recording started")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Permissions not granted")),
        );
      }
    }
    Future<void>stopRecording()async{
      filePath = await record.stop();
      debugPrint('Recording saved at :$filePath');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Recording stopped")),
      );
    }

    Future<void> playRecording()async{
      if(filePath!=null){
        await audioPlayer.play(DeviceFileSource(filePath!));
        debugPrint("Playing: $filePath");
      }
    }

    Future<void> stopPlaying() async {
      await audioPlayer.stop();
      debugPrint("Stopped playing");
    }

    void voicebox(){
      showDialog(context: context, builder: (context)=>
          AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ,
              content: Column(mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/images/microphone-black-shape.png",height: 50,width: 50,),
                  SizedBox(height: 10.0,),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              side: BorderSide(color: Colors.grey)),
                          onPressed: () {
                            startRecording();
                          }, child: Text("RECORD")),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              foregroundColor: Colors.black,
                              side: BorderSide(color: Colors.grey)),
                          onPressed: () {
                            stopRecording();
                          }, child: Text("STOP")),
                      ElevatedButton(style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          foregroundColor: Colors.black,
                          side: BorderSide(color: Colors.grey)),
                          onPressed: () {
                            playRecording();
                          }, child: Text("PLAY")),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              side: BorderSide(color: Colors.grey)),
                          onPressed: () {
                            stopPlaying();
                          }, child: Text("STOP PLAYING RECORDING")),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.green,
                        side: BorderSide(color: Colors.green)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("CONFIRM"),
                  ),
                ],
              )
          ));
    }

    Future<void> uploadToFirebase()async{
      setState(() => isUploading = true);
      try{
        if(selectedValue == 'Text'){
          await FirebaseFirestore.instance.collection('voicecalls').doc('classwise').set({
            'class': selectedItem,
            'type': 'Text',
            'message': announcementController.text.trim(),
            'timestamp': FieldValue.serverTimestamp()
          });
          Fluttertoast.showToast(msg: "Text uploaded successfully");
        }else if(selectedValue == 'Voice') {
          if(filePath == null){
            print('No file recorded yet!');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please record before uploading!')),
            );
            return;
          }
          print('Uploading voice from: $filePath');
          final file = File(filePath!);
          if(!await file.exists()){
            print('File not found on device!');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Recording file not found!')),
            );
            return;
          }
          final fileName = 'voice_${DateTime.now().microsecondsSinceEpoch}.m4a';
          final ref = FirebaseStorage.instance.ref().child('voice_announcements/$fileName');
          await ref.putFile(file);
          final downloadUrl = await ref.getDownloadURL();
          await FirebaseFirestore.instance.collection('voice_announcements').add(
              {
                'class': selectedItem,
                'type': 'Voice',
                'url': downloadUrl,
                'timestamp': FieldValue.serverTimestamp(),
              });
          Fluttertoast.showToast(
            msg: 'Uploaded Successfully',
            backgroundColor: Colors.green,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        }else {
          print('No type selected');        }
      }catch(e){
        debugPrint("Upload error: $e");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }finally {
        setState(() => isUploading = false
        );
      }
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.blueGrey.shade900, // just for visibility
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 35.0,),
                /// Communication Type Row
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Communication Type :",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: DropdownButtonFormField<String>(
                        value: selectedValue,style: TextStyle(color: Colors.white),
                        isExpanded: true,dropdownColor: Colors.white,
                        decoration: InputDecoration(fillColor: Colors.white,filled: true,hint: Text("Select Type"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        items: items.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: const TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedValue = newValue;
                          });

                          const SizedBox(height: 20);
                          if(newValue == "Voice") {
                            voicebox();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                if(selectedValue =="Text")
                /// Announcement Row
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          "Announcement   :",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: TextFormField(maxLines: 3,
                          controller: announcementController,
                          decoration: InputDecoration(filled: true,fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Enter Announcement ",
                              hintStyle: TextStyle(color: Colors.grey.shade600)
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Select Class :",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: DropdownButtonFormField<String>(
                        value: selectedItem,style: TextStyle(color: Colors.black),
                        isExpanded: true,dropdownColor: Colors.white,hint: Text("Select Class"),
                        decoration: InputDecoration(filled: true,fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        items: list.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: const TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedItem = newValue;
                          });

                          const SizedBox(height: 20);
                          if(newValue == "Voice") {
                            voicebox();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Center(
                    child:
                    ElevatedButton(style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(side: BorderSide(width: 2,color: Colors.white),borderRadius: BorderRadius.circular(10))
                    ),
                        onPressed: isUploading ? null : uploadToFirebase,
                        child: isUploading ? CircularProgressIndicator(color: Colors.white,)
                        : Text("SUBMIT"))
                )],
            ),
          ),
        ),
      );
    }
}