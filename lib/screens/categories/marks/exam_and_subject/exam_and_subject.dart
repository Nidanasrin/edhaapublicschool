import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/marks/exam_and_subject/delete_examsubjects/delete_examsubjects.dart';
import 'package:raynottschool/screens/categories/marks/exam_and_subject/new_examsmarks_creation/new_examsmarks_creation.dart';
import 'package:raynottschool/screens/categories/marks/exam_and_subject/update_maxmarks/update_maxmarks.dart';

class ExamAndSubject extends StatefulWidget {
  const ExamAndSubject({super.key});

  @override
  State<ExamAndSubject> createState() => _ExamAndSubjectState();
}

class _ExamAndSubjectState extends State<ExamAndSubject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueGrey.shade900,
      body:
      Center(
        child:  Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MarksCreation()));
                },
                child: buildContainer("NEW EXAMS/MARKS CREATION"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateMaxmarks()));
                },
                child:
                buildContainer("UPDATE MAX MARKS"),
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DeleteExamsubjects()));
                },
                child:
                buildContainer("DELETE EXAM SUBJECTS"),),

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