import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/registration_status/app_users/app_users.dart';
import 'package:raynottschool/screens/categories/registration_status/phase1/phase1.dart';
import 'package:raynottschool/screens/categories/registration_status/phase2/phase2.dart';
import 'package:raynottschool/screens/categories/registration_status/student_registrationstatus/studentregistration_status.dart';

class RegistrationStatus extends StatefulWidget {
  const RegistrationStatus({super.key});

  @override
  State<RegistrationStatus> createState() => _RegistrationStatusState();
}

class _RegistrationStatusState extends State<RegistrationStatus> {
  int users = 0;
  int nonUsers = 175;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child:  Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentregistrationStatus()));
                },
                child: buildContainer("STUDENT REGISTRATION STATUS"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AppUsers(users: users, nonUsers: nonUsers)));
                },
                child:
                buildContainer("APP USERS"),
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Phase1()));
                },
                child:
                buildContainer("PHASE 1"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Phase2()));
                },
                child:
                buildContainer("PHASE 2"),),

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