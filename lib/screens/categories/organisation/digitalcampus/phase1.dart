import 'package:flutter/material.dart';

class Phase1 extends StatefulWidget {
  const Phase1({super.key});

  @override
  State<Phase1> createState() => _Phase1State();
}

class _Phase1State extends State<Phase1> {
  List<String> list = [
    "Welcome Call & Introducing Digital Campus Expert",
    "Getting Started : Download App,Login,Signing of Policies & WebLogins",
    "Types of Login: School Admin/Parent/Teacher/Accountant/Forgot/Change Password",
    "Class Creation/Edit/Delete",
    "Staff Creation/Edit/Delete/Class Teacher Mapping/Staff Access,Staff Login",
    "Student Registration/Edit/Delete/Block/Photo Taking",
    "Communication : App Notifications/Voice Calls/Voice Announcements/SMS",
    "Attendance : Roll No Update/Daily Attendance/Monthly Attendance",
    "Homework",
    "Marks : Subject - Exams Creations/Mappings,Marks Insertions/Progress Report/Hall Tickets/Analytics"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white10,
      body: ListView.separated(padding: EdgeInsets.only(top: 10.0),
        itemCount: list.length,
        separatorBuilder: ( context, index) => const Divider(
          color: Colors.white54,
          thickness: 0.5,height: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          final tile = list[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Text("Step ${index +1 }",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            Text(
            (index == 0 || index == 1) ? "COMPLETED" : "PENDING",
            style: TextStyle(
            color: (index == 0 || index == 1) ? Colors.green : Colors.red,
            fontSize: 16,fontWeight: FontWeight.bold
            ),
            )
            ],
                ),
                SizedBox(height: 5,),
                Text(tile,style: TextStyle(fontSize: 16,color: Colors.white),)
              ],
            ),
          );
        },),
    );
  }
}
