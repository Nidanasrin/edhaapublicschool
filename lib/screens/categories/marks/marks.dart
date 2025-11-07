import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/marks/exam_and_subject/exam_and_subject.dart';
import 'package:raynottschool/screens/categories/marks/examinations_creation/examinations_creation.dart';
import 'package:raynottschool/screens/categories/marks/marks_details/marks_details.dart';
import 'package:raynottschool/screens/categories/marks/marks_insertion/marks_insertions.dart';
import 'package:raynottschool/screens/categories/marks/subject_creation/subject_creation.dart';

class Marks extends StatefulWidget {
  const Marks({super.key});

  @override
  State<Marks> createState() => _MarksState();
}

class _MarksState extends State<Marks> {
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SubjectCreation()));
                },
                child: buildContainer("SUBJECT CREATION"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ExaminationsCreation()));
                },
                child:
                buildContainer("EXAMINATIONS CREATION"),
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ExamAndSubject()));
                },
                child:
                buildContainer("EXAM AND SUBJECT"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MarksInsertions()));
                },
                child:
                buildContainer("MARKS INSERTIONS"),),
              SizedBox(height: 15,),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> MarksDetails()));
                  },
                  child:
                  buildContainer("MARK DETAILS")),

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
        BorderRadius.circular(10)),
    child: Text(text,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
  );
}
