import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/analytics/student_wise/student_wise.dart';
import 'package:raynottschool/screens/categories/analytics/subject_wise/subject_wise.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child:  Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SubjectWise()));
                },
                child: buildContainer("SUBJECTS WISE"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentWise()));
                },
                child:
                buildContainer("STUDENTS WISE"),
              ),
            ]
        ),
      ),
    );
  }
}
Widget buildContainer(String text) {
  return Container(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        borderRadius:
        BorderRadius.circular(10)),
    child: Text(text, style: TextStyle(
        color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
  );
}