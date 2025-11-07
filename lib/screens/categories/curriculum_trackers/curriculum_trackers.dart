import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/curriculum_trackers/create_curriculum.dart';
import 'package:raynottschool/screens/categories/curriculum_trackers/track_currciculum.dart';

class CurriculumTrackers extends StatefulWidget {
  const CurriculumTrackers({super.key});

  @override
  State<CurriculumTrackers> createState() => _CurriculumTrackersState();
}

class _CurriculumTrackersState extends State<CurriculumTrackers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body:
      Center(
        child:  Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> TrackCurrciculum()));
                },
                child: buildContainer("TRACK CURRICULUM"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateCurriculum()));
                },
                child:
                buildContainer("CREATE CURRICULUM"),
              ),
            ]
        ),
      ),
    );
  }
}
Widget buildContainer(String text){
  return Container(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.white,width: 2),
        borderRadius:
        BorderRadius.circular(5)),
    child: Text(text,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
  );
}
