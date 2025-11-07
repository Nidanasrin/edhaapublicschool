import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'package:raynottschool/screens/categories/staff_details/classteacher_details/classteacher_details.dart';
import 'package:raynottschool/screens/categories/staff_details/digital_campus_poc/digitalcampus_poc.dart';
import 'package:raynottschool/screens/categories/staff_details/staff_access/staff_access.dart';
import 'package:raynottschool/screens/categories/staff_details/staff_attendance/staff_attendance.dart';
import 'package:raynottschool/screens/categories/staff_details/staff_details/staff_details.dart';
import 'package:raynottschool/screens/categories/staff_details/staff_monthly_attendance/staff_monthly_attendance.dart';

class StaffDetails extends StatefulWidget {
  const StaffDetails({super.key});

  @override
  State<StaffDetails> createState() => _StaffDetailsState();
}

class _StaffDetailsState extends State<StaffDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child:  Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> StaffAttendance()));
                },
                child: buildContainer("STAFF ATTENDANCE"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> StaffDetailscat(selectedStaff: staffNames)));
                },
                child:
                buildContainer("STAFF DETAILS"),
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> StaffMonthlyAttendance()));
                },
                child:
                buildContainer("STAFF MONTHLY ATTENDANCE"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DigitalcampusPoc()));
                },
                child:
                buildContainer("DIGITAL CAMPUS POC"),),
              SizedBox(height: 15,),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ClassteacherDetails()));
                  },
                  child:
                  buildContainer("CLASS TEACHER DETAILS")),
              SizedBox(height: 15,),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> StaffAccess()));
                  },
                  child:
                  buildContainer("STAFF ACCESS")),
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
