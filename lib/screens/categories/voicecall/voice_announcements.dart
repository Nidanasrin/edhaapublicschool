import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/voicecall/voiceannouncement_form.dart';

class VoiceAnnouncements extends StatefulWidget {
  const VoiceAnnouncements({super.key});

  @override
  State<VoiceAnnouncements> createState() => _VoiceAnnouncementsState();
}

class _VoiceAnnouncementsState extends State<VoiceAnnouncements> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueGrey.shade900,
   body: Padding(
     padding: const EdgeInsets.all(10.0),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.end,crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Center(
           child: ElevatedButton(
             style: ElevatedButton.styleFrom(
               foregroundColor: Colors.white,
               backgroundColor: Colors.transparent,
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(width: 2,color: Colors.white))
             ),
               onPressed: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=> VoiceannouncementForm()));
               }, child: Text("RELEASE VOICE ANNOUNCEMENTS")),
         ),
       ],
     ),
   ),
    );
  }
}
