import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

class VoiceannouncementForm extends StatefulWidget {
  const VoiceannouncementForm({super.key});

  @override
  State<VoiceannouncementForm> createState() => _VoiceannouncementFormState();
}

class _VoiceannouncementFormState extends State<VoiceannouncementForm> {
  final record = AudioRecorder();
  final audioPlayer =AudioPlayer();
  String? filePath;

  Future<void> startRecording()async{
    if(await record.hasPermission()){
      final path = "/storage/emulated/0/Download/recording_${DateTime.now().millisecondsSinceEpoch}.m4a";
      await record.start(RecordConfig(encoder: AudioEncoder.aacLc),path: path);
      filePath = path;
      debugPrint('Recording started: $path');
    }
  }
  Future<void>stopRecording()async{
    filePath = await record.stop();
    debugPrint('Recording saved at :$filePath');
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
                          startRecording();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueGrey.shade900,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Row(
                    children: [
                  Expanded(flex: 4,
                      child: Text("Title                           :",style: TextStyle(color: Colors.white,fontSize: 16),)),
                  Expanded(flex: 5,
                      child: TextField(
                     decoration: InputDecoration(
                       hint: Text("Title",style: TextStyle(color: Colors.grey),),fillColor: Colors.white,
                       filled: true,
                     ),
                  ))
                ],
              ),SizedBox(height: 15,),
                  Row(
                    children: [
                      Expanded(flex: 4,
                          child: Text("Description               :",style: TextStyle(color: Colors.white,fontSize: 16),)),
                      Expanded(flex: 5,
                          child: TextField(
                            decoration: InputDecoration(
                              hint: Text("Description",style: TextStyle(color: Colors.grey),),fillColor: Colors.white,
                              filled: true,
                            ),maxLines: 3,
                          ))
                    ],
                  ),SizedBox(height: 15,),
                  Row(
                    children: [
                      Expanded(flex: 4,
                          child: Text("Submitted By            :",style: TextStyle(color: Colors.white,fontSize: 16),)),
                      Expanded(flex: 5,
                          child: TextField(
                            decoration: InputDecoration(
                              hint: Text("Name",style: TextStyle(color: Colors.grey),),fillColor: Colors.white,
                              filled: true,
                            ),
                          ))
                    ],
                  ),
                  SizedBox(height: 50,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(width: 2,color: Colors.white),)
                    ),
                      onPressed: (){
                      voicebox();
                      }, child: Text("RECORD VOICE")),
                  SizedBox(height: 20,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(width: 2,color: Colors.white),)
                      ),
                      onPressed: (){}, child: Text("SUBMIT"))
      ]
              )
            ),
    );
  }
}
