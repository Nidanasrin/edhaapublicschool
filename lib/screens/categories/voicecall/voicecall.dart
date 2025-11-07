import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/voicecall/classwise.dart';
import 'package:raynottschool/screens/categories/voicecall/greetings.dart';
import 'package:raynottschool/screens/categories/voicecall/organisation_wise.dart';
import 'package:raynottschool/screens/categories/voicecall/sms.dart';
import 'package:raynottschool/screens/categories/voicecall/voice_announcements.dart';

class Voicecall extends StatefulWidget {
  const Voicecall({super.key});

  @override
  State<Voicecall> createState() => _VoicecallState();
}

class _VoicecallState extends State<Voicecall> {

  void msgbox() {
    showDialog(context: context, builder: (context) =>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          title: Text("Message"),
          content: Text(
              "Please Recharge your SMS Balance.For any quires please contact Student Unique Card Team.Phone : (+91) 7093600613 or mail : support@studentuniquecard.com"),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context);
            },
                child: Text(
                  "Ok", style: TextStyle(color: Colors.indigo.shade900),))
          ],
        ));
  }

  void voicemsgbox() {
    showDialog(context: context, builder: (context) =>
        AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ), backgroundColor: Colors.white,
            content: Column(mainAxisSize: MainAxisSize.min,

                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  color: Colors.indigo.shade900, width: 2)),
                          foregroundColor: Colors.indigo.shade900
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => OrganisationWise()));
                      }, child: Text("ORGANIZATION WISE")),
                  SizedBox(height: 10,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                  width: 2, color: Colors.indigo.shade900)),
                          foregroundColor: Colors.indigo.shade900),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Classwise()));
                      }, child: Text("CLASS WISE"))
                ]
            )
        )
    );
  }
  void msgBoxAnnouncement(){
    showDialog(context: context, builder: (context)=>
    AlertDialog(
      backgroundColor: Colors.white,
      title: Text("Meesage"),
        content: Text("No Announcements Found"),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context)=> VoiceAnnouncements()));
        }, child: Text("OK"))
      ],
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body:  Center(
        child:  Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            GestureDetector(
            onTap: (){
            msgbox();
      },
        child: buildContainer("SMS"),),
      SizedBox(height: 15,),
      GestureDetector(
        onTap: (){
          voicemsgbox();
          //Navigator.push(context, MaterialPageRoute(builder: (context)=> Voicecall()));
        },
        child:
        buildContainer("VOICE CALLS"),
      ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> GreetingForm()));
                },
                child:
                buildContainer("GREETINGS"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  msgBoxAnnouncement();
                },
                child:
                buildContainer("VOICE ANNOUNCEMENTS"),),
      ]
    )
      )
    );
  }
}
Widget buildContainer(String text){
  return Container(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.white,width: 2),
        borderRadius:
        BorderRadius.circular(10)),
    child: Text(text,style: TextStyle(color: Colors.white,fontSize: 15),),
  );
}
