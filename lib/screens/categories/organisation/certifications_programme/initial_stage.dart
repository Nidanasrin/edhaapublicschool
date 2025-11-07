import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/organisation/certifications_programme/applyforcertification_initial.dart';
import 'package:raynottschool/screens/categories/organisation/certifications_programme/video_classes_initial.dart';

class InitialStage extends StatefulWidget {
  const InitialStage({super.key});

  @override
  State<InitialStage> createState() => _InitialStageState();
}

class _InitialStageState extends State<InitialStage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Center(
        child:  Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            GestureDetector(
            onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> VideoClasses()));
      },
        child: buildContainer("VIDEO CLASSES "),),
        SizedBox(height: 15,),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Applyforcertification()));
          },
          child:
          buildContainer("APPLY FOR CERTIFICATIONS"),
        ),
    ])
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