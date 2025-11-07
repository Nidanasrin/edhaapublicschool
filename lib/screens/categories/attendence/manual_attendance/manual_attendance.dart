import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/attendence/manual_attendance/attendance_settings/attendence_settings.dart';
import 'package:raynottschool/screens/categories/attendence/manual_attendance/attendence_reports/attendance_reports.dart';
import 'package:raynottschool/screens/categories/attendence/manual_attendance/daily_attendance/daily_attendence.dart';
import 'package:raynottschool/screens/categories/attendence/manual_attendance/monthly_attendance/monthlyattendance.dart';
import 'package:raynottschool/screens/categories/attendence/manual_attendance/rollno_update/rollno_update.dart';
import 'package:raynottschool/screens/categories/attendence/manual_attendance/set_holidays/set_holiday.dart';

class ManualAttendance extends StatefulWidget {
  const ManualAttendance({super.key});

  @override
  State<ManualAttendance> createState() => _ManualAttendanceState();
}

class _ManualAttendanceState extends State<ManualAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child:  Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> RollnoUpdate()));
                },
                child: buildContainer("ROLL NO UPDATE"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DailyAttendence()));
                },
                child:
                buildContainer("DAILY ATTENDANCE"),
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Monthlyattendance()));
                },
                child:
                buildContainer("MONTHLY ATTENDANCE"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AttendanceReports()));
                },
                child:
                buildContainer("ATTENDANCE REPORTS"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AttendenceSettings()));
                },
                child:
                buildContainer("ATTENDANCE SETTINGS"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SetHoliday()));
                },
                child:
                buildContainer("SET HOLIDAYS"),),
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
