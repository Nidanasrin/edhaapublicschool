import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'package:raynottschool/screens/categories/attendence/face_attendance/custom_reports.dart';
import 'package:raynottschool/screens/categories/attendence/face_attendance/daywise.dart';
import 'package:raynottschool/screens/categories/attendence/face_attendance/face_mapping.dart';
import 'package:raynottschool/screens/categories/attendence/face_attendance/setcutofftime.dart';
import 'package:raynottschool/screens/categories/attendence/face_attendance/settings.dart';

class FaceAttendence extends StatefulWidget {
  const FaceAttendence({super.key});

  @override
  State<FaceAttendence> createState() => _FaceAttendenceState();
}

class _FaceAttendenceState extends State<FaceAttendence> {
  String? todayDate;

  @override
  void initState() {
    super.initState();
    todayDate = DateFormat('dd MMM yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.calendar_month,
                    color: Colors.deepPurple.shade900,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            buildRow("Attendance Date", todayDate!),
            SizedBox(height: 25),
            Text(
              "Staff Attendance Details",
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            buildRow("Total", "22"),
            SizedBox(height: 20),
            buildRow("Present", "0"),
            SizedBox(height: 20),
            buildRow("Absent", "22"),
            SizedBox(height: 20),
            buildRow("Present %", "0.0%"),
            SizedBox(height: 20),
            buildRow("Absent %", "100.0%"),
            SizedBox(height: 20),
            Text(
              "Student Attendance",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
            SizedBox(height: 20),
            buildRow("Total", "175"),
            SizedBox(height: 20),
            buildRow("Present", "0"),
            SizedBox(height: 20),
            buildRow("Absent", "175"),
            SizedBox(height: 20),
            buildRow("Present %", "0.0%"),
            SizedBox(height: 20),
            buildRow("Absent %", "100.0%"),
            SizedBox(height: 20),
            Wrap(alignment: WrapAlignment.center,
              runSpacing: 10,
              spacing: 10,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Daywise()));
                  },
                  child: Text("DAY WISE REPORTS",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomReports()));

                  },
                  child: Text("CUSTOM REPORTS",style: TextStyle(fontWeight: FontWeight.bold),),
                ),ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Settings()));

                  },
                  child: Text("SETTINGS",style: TextStyle(fontWeight: FontWeight.bold),),
                ),ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Setcutofftime(staffList: staffNames, classList: list,)));

                  },
                  child: Text("SET CUT-OFF TIME",style: TextStyle(fontWeight: FontWeight.bold),),
                ),ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> FaceMapping()));

                  },
                  child: Text("FACE MAPPING",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildRow(String title, String value) {
  return Row(crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      Text(value, style: TextStyle(color: title=="Present %" ? Colors.green : title=="Absent %" ? Colors.orange : Colors.white , fontSize: 16,fontWeight: FontWeight.bold)),
    ],
  );
}
