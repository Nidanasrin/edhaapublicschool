import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/attendence/manual_attendance/attendence_reports/table.dart';

class AttendanceReports2 extends StatefulWidget {
  const AttendanceReports2({super.key});

  @override
  State<AttendanceReports2> createState() => _AttendanceReports2State();
}

class _AttendanceReports2State extends State<AttendanceReports2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60,),
            Row(
              children: [
            Text("Total Students",style: TextStyle(color: Colors.white,fontSize: 16),),
            Text(":   175",style: TextStyle(color: Colors.white,fontSize: 16),),
            ]
            ),SizedBox(height: 20,),

            Row(
                children: [
                  Text("Total Absentees",style: TextStyle(color: Colors.white,fontSize: 16),),
                  Text(":   3",style: TextStyle(color: Colors.white,fontSize: 16),),
                ]
            ),
            Divider(thickness: 1,height: 30,),
            Row(
                children: [
                  Text("Total Present",style: TextStyle(color: Colors.white,fontSize: 16),),
                  Text(":   175",style: TextStyle(color: Colors.white,fontSize: 16),),
                ]
            ),
            Divider(thickness: 1,height: 30,),
            SizedBox(height: 40.0,),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape:
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.white,width: 2),
                      ),backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white
                  ),
                  onPressed: (){
                      //
                    //
                    //
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AttendanceTable()));
                  }, child: Text("CLASS WISE REPOST")),
            )
          ],
        ),
      ),
    );
  }
}
