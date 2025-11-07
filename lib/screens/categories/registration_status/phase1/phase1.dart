import 'package:flutter/material.dart';

class Phase1 extends StatefulWidget {
  const Phase1({super.key});

  @override
  State<Phase1> createState() => _Phase1State();
}

class _Phase1State extends State<Phase1> {
  List<String> text = [
    "Welcome Call & Introducing Digital Campus Expert",
    "Getting Started : Download App ,Login,Signing of Policies & WebLogin",
    "Types of Logins : School Admin/Parent/Teacher/Accountant/Forgot/Change Password",
    "Class Creation/Edit/Delete",
    "Staff Creation/Edit/Delete/Class Teacher Mapping/Staff Access/Staff Login",
    "Student Registration/Edit/Edit/Block/Photo Taking",
    "Communication : App Notifications/Voice Calls/Voice Announcements/SMS",
    "Attendance : Roll No Update/Daily Attendance/Monthly Attendance",
    "Homework",
    "Marks : Subject-Exams Creations/Mapping/,Marks Insertions/Progress Report/Hall tickets/Analytics"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.separated(itemBuilder: (context,index){
              final list = text[index];
              return ListTile(
                title: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Text("Step ${index+1}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

                    if(index <=2)
                      Text("COMPLETED",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),)
                    else Text("PENDING",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                  ],
                ),
                    SizedBox(height: 7,),
                    Text(list,style: TextStyle(color: Colors.white,fontSize: 15),)
                ]
                )
              );
            }, separatorBuilder: (context,index)=> Divider(thickness: 1,height: 10,), itemCount: text.length),
          )
        ],
      ),
    );
  }
}
