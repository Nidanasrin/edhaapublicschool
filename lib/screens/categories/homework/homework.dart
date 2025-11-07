import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/homework/assign_homework.dart';
import 'package:raynottschool/screens/categories/homework/individual_homework.dart';
import 'package:raynottschool/screens/categories/homework/view_homework.dart';

class Homework extends StatefulWidget {
  const Homework({super.key});

  @override
  State<Homework> createState() => _HomeworkState();
}

class _HomeworkState extends State<Homework> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child:  Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewHomework()));
                },
                child: buildContainer("VIEW HOME WORK"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AssignHomework()));
                },
                child:
                buildContainer("ASSIGN HOMEWORK"),
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> IndividualHomework()));
                },
                child:
                buildContainer("INDIVIDUAL HOMEWORK"),),

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
