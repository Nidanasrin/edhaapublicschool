import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/attendence/manual_attendance/attendence_reports/table.dart';

class AttendanceReports2 extends StatefulWidget {
  const AttendanceReports2({super.key});

  @override
  State<AttendanceReports2> createState() => _AttendanceReports2State();
}

class _AttendanceReports2State extends State<AttendanceReports2> {
  int totalStudents = 0;
  int totalAbsentees = 0;
  int totalPresent = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDashboardCounts();
  }

  Future<void> fetchDashboardCounts() async {
    final dateId = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";

    final snapshot = await FirebaseFirestore.instance
    .collection('attendance')
        .doc('manual_attendance')
        .collection("attendance_reports")
        .doc(dateId)
        .collection("classes")
        .get();

    int tStudents = 0;
    int tAbsent = 0;

    for (var doc in snapshot.docs) {
      tStudents += (doc["totalStudents"] ?? 0) as int;
      tAbsent += (doc["absentStudents"] ?? 0) as int;
    }

    setState(() {
      totalStudents = tStudents;
      totalAbsentees = tAbsent;
      totalPresent = tStudents - tAbsent;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }
      return Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60,),
              Row(
                children: [
                  Text("Total Students",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  Text(":   $totalStudents",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),

              SizedBox(height: 20),

              // TOTAL ABSENTEES
              Row(
                children: [
                  Text("Total Absentees",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  Text(":   $totalAbsentees",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),

              Divider(thickness: 1, height: 30),

              // TOTAL PRESENT
              Row(
                children: [
                  Text("Total Present",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  Text(":   $totalPresent",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),

              Divider(thickness: 1, height: 30),

              SizedBox(height: 40),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AttendanceTable()),
                    );
                  },
                  child: Text("CLASS WISE REPORT"),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
