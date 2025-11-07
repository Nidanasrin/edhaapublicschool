import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/attendence/manual_attendance/daily_attendance/dailyattendance_details2.dart';

import '../../../../../dummydata/datas.dart';

class dailyAttendenceDetail extends StatefulWidget {
  final String className;
  final List<String> students;
  final String date;

  const dailyAttendenceDetail({
    super.key,
    required this.className,
    required this.students,
    required this.date,
  });

  @override
  State<dailyAttendenceDetail> createState() => _dailyAttendenceDetailState();
}

class _dailyAttendenceDetailState extends State<dailyAttendenceDetail> {
  Set<int> absentStudents = {};
  List<String> getStudentList(String className) {
    switch (className) {
      case "NURSERY":
        return nursery;
      case "LKG":
        return lkg;
      case "UKG":
        return ukg;
      case "GRADE-1":
        return grade1;
      case "GRADE-2":
        return grade2;
      case "GRADE-3":
        return grade3;
      case "GRADE-4":
        return grade4;
      case "GRADE-5":
        return grade5;
      case "GRADE-6":
        return grade6;
      case "GRADE-7":
        return grade7;
      case "GRADE 8 STATE SYLLABUS":
        return grade8State;
      case "DAY CARE":
        return daycare;
      case "GRADE 7 STATE SYLLABUS":
        return grade7State;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final students  = getStudentList(widget.className);
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green.shade900,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text("Class :", style: TextStyle(fontSize: 14)),
            SizedBox(width: 4),
            Text(
              widget.className,
              style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          Text("Date: ", style: TextStyle(fontSize: 16)),
          Text(
            widget.date,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,

                ),
                itemCount: students.length,
                itemBuilder: (context, index) {
                  bool isAbsent = absentStudents.contains(index);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isAbsent) {
                          absentStudents.remove(index);
                        } else {
                          absentStudents.add(index);
                        }
                      });
                    },
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.transparent,
                      child: Container(height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isAbsent ? Colors.red : Colors.white,
                            width: 2,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "${index+1}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.green.shade900,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Absentees : ${absentStudents.length}",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: BorderSide(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DailyattendanceDetails2(className: widget.className, students: students, date: widget.date, absentees: absentStudents,)));
                  },
                  child: Text("NEXT", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
