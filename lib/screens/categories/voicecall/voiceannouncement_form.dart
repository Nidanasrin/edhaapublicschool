import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class VoiceannouncementForm extends StatefulWidget {
  const VoiceannouncementForm({super.key});

  @override
  State<VoiceannouncementForm> createState() => _VoiceannouncementFormState();
}

class _VoiceannouncementFormState extends State<VoiceannouncementForm> {
  final record = AudioRecorder();
  final audioPlayer = AudioPlayer();
  final formkey = GlobalKey<FormState>();
  String? filePath;
  bool isUploading = false;
  bool isRecording = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController submittedByController = TextEditingController();

  Future<bool> requestPermissions() async {
    var mic = await Permission.microphone.request();
    var storage = await Permission.storage.request();
    return mic.isGranted && storage.isGranted;
  }

  Future<void> startRecording() async {
    if (await requestPermissions()) {
      final dir = await getApplicationDocumentsDirectory();
      final path =
          '${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
      filePath = path;
      await record.start(
        const RecordConfig(encoder: AudioEncoder.aacLc, bitRate: 128000, sampleRate: 44100),
        path: filePath!,
      );
      setState(() => isRecording = true);
      debugPrint('Recording started: $path');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Recording started")));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Permissions not granted")));
    }
  }

  Future<void> stopRecording() async {
    filePath = await record.stop();
    setState(() => isRecording = false);
    debugPrint('Recording saved at :$filePath');
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Recording stopped")));
  }

  Future<void> playRecording() async {
    if (filePath != null) {
      await audioPlayer.play(DeviceFileSource(filePath!));
      debugPrint("Playing: $filePath");
    }
  }

  Future<void> stopPlaying() async {
    await audioPlayer.stop();
    debugPrint("Stopped playing");
  }

  void voicebox() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (context, setStateDialog) {
              return AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/microphone-black-shape.png",
                      height: 50,
                      width: 50,
                    ),
                    const SizedBox(height: 10.0),
                    if (isRecording)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.fiber_manual_record, color: Colors.red),
                          SizedBox(width: 6),
                          Text("Recording...", style: TextStyle(color: Colors
                              .red)),
                        ],
                      ),
                    SizedBox(height: 10.0),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: BorderSide(color: Colors.grey),
                          ),
                          onPressed: isRecording
                              ? null
                              : () async {
                            await startRecording();
                            setStateDialog(() => isRecording = true);
                          },
                          child: Text("RECORD"),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            foregroundColor: Colors.black,
                            side: BorderSide(color: Colors.grey),
                          ),
                          onPressed: !isRecording
                              ? null
                              : () async {
                            await stopRecording();
                            setStateDialog(() => isRecording = false);
                          },
                          child: Text("STOP"),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            foregroundColor: Colors.black,
                            side: BorderSide(color: Colors.grey),
                          ),
                          onPressed: () {
                            playRecording();
                          },
                          child: Text("PLAY"),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: BorderSide(color: Colors.grey),
                          ),
                          onPressed: () {
                            stopPlaying();
                          },
                          child: Text("STOP PLAYING RECORDING"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.green,
                        side: BorderSide(color: Colors.green),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("CONFIRM"),
                    ),
                  ],
                ),
              );
            });
      }
    );
  }

  Future<void> uploadToFirebase() async {
    if (titleController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty ||
        submittedByController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all text fields");
      return;
    }
    if (filePath == null || !File(filePath!).existsSync()) {
      Fluttertoast.showToast(msg: "Please record your voice before submitting");
      return;
    }
    setState(() => isUploading = true);
    try {
      String? audioUrl;

      // ✅ Only upload audio if user recorded something
      if (filePath != null && File(filePath!).existsSync()) {
        final audioRef = FirebaseStorage.instance.ref().child(
          'voice_announcements/${DateTime.now().millisecondsSinceEpoch}.m4a',
        );
        await audioRef.putFile(File(filePath!));
        audioUrl = await audioRef.getDownloadURL();
      }
      await FirebaseFirestore.instance
          .collection('voice_announcements')
          .add({
        'title': titleController.text.trim(),
        'description': descriptionController.text.trim(),
        'submitted_by': submittedByController.text.trim(),
        'voice_url': audioUrl ?? '', // empty if no voice
        'timestamp': FieldValue.serverTimestamp(),
      });
      Fluttertoast.showToast(msg: "Uploaded successfully!");
      titleController.clear();
      descriptionController.clear();
      submittedByController.clear();
      setState(() => filePath = null);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }finally {
      setState(() => isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Title                           :",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hint: Text(
                          "Title",
                          style: TextStyle(color: Colors.grey),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Description               :",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hint: Text(
                          "Description",
                          style: TextStyle(color: Colors.grey),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Submitted By            :",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: TextField(
                      controller: submittedByController,
                      decoration: InputDecoration(
                        hint: Text(
                          "Name",
                          style: TextStyle(color: Colors.grey),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 2, color: Colors.white),
                  ),
                ),
                onPressed: () {
                  voicebox();
                },
                child: Text("RECORD VOICE"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 2, color: Colors.white),
                  ),
                ),
                onPressed: isUploading ? null : uploadToFirebase,
                child: isUploading ? CircularProgressIndicator(color: Colors.white,)
                : Text("SUBMIT"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
