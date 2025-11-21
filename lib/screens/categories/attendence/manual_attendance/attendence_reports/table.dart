import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';

class AttendanceTable extends StatefulWidget {
  const AttendanceTable({super.key});

  @override
  State<AttendanceTable> createState() => _AttendanceTableState();
}

class _AttendanceTableState extends State<AttendanceTable> {
  final Map<String, int> absentStudents = {
    "NURSERY": 3,
    "LKG": 0,
    "UKG": 0,
    "GRADE-1": 0,
    "GRADE-2": 0,
    "GRADE-3": 0,
    "GRADE-4": 0,
  };
  @override
  Widget build(BuildContext context) {
    final dateId = '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    return Scaffold(backgroundColor: Colors.blueGrey.shade900,
       body:   Padding(
        padding: const EdgeInsets.only(top: 60.0),
    child: StreamBuilder(
    stream: FirebaseFirestore.instance
    .collection("attendance_reports")
        .doc(dateId)
        .collection("classes")
        .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(
            child: CircularProgressIndicator(color: Colors.white));
      }

      final docs = snapshot.data!.docs;
      if (docs.isEmpty) {
        return const Center(
          child: Text("No attendance data found",
              style: TextStyle(color: Colors.white, fontSize: 16)),
        );
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            headingRowColor: WidgetStateProperty.all(
                Colors.blueGrey.shade900),
            border: TableBorder.all(color: Colors.white),

            columns: [
              DataColumn(
                label: Text("Class Name",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              DataColumn(
                label: Text("Total Students",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              DataColumn(
                label: Text("Absent Students",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              DataColumn(
                label: Text("Present Students",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ], rows: docs.map((doc) {
              final data = doc.data() as Map<String,dynamic>;
          final className = doc.id;
          final total = data['totalStudents'] ?? 0;
          final absent = data['absentStudents'] ?? 0;
          final present = total - absent;
          return DataRow(cells: [
            DataCell(Text(className,
                style: const TextStyle(color: Colors.white))),
            DataCell(Text(total.toString(),
                style: const TextStyle(color: Colors.white))),
            DataCell(Text(absent.toString(),
                style: const TextStyle(color: Colors.white))),
            DataCell(Text(present.toString(),
                style: const TextStyle(color: Colors.white))),
          ]);
        }).toList()),
      );
    }
            ),
       ),

       );
  }
}
