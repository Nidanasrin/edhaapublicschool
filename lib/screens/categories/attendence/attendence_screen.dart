import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/attendence/face_attendance/face_attendence.dart';
import 'package:raynottschool/screens/categories/attendence/manual_attendance/manual_attendance.dart';

class AttendenceScreen extends StatefulWidget {
  const AttendenceScreen({super.key});

  @override
  State<AttendenceScreen> createState() => _AttendenceScreenState();
}

class _AttendenceScreenState extends State<AttendenceScreen> {

  void smartBox(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.white,
          title: Text("Message",style: TextStyle(fontWeight: FontWeight.bold),),
          content: Text("To Activate Smart Attendance Feature Please Call +917093600610/13/30"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900
            ),))
          ],
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child:  Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ManualAttendance()));
                },
                child: buildContainer("MANUAL ATTENDANCE"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  smartBox();
                },
                child:
                buildContainer("SMART ATTENDANCE"),
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> FaceAttendence()));
                },
                child:
                buildContainer("FACE ATTENDANCE"),),
              SizedBox(height: 15,),

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
    child: Text(text,style: TextStyle(color: Colors.white,fontSize: 15),),
  );
}
