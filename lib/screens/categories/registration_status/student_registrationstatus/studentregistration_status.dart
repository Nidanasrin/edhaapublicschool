import 'package:flutter/material.dart';

import '../../../../dummydata/datas.dart';

class StudentregistrationStatus extends StatefulWidget {
  const StudentregistrationStatus({super.key});

  @override
  State<StudentregistrationStatus> createState() => _StudentregistrationStatusState();
}

class _StudentregistrationStatusState extends State<StudentregistrationStatus> {
  List<int> count = [
    10,25,30,30,30,30,30,30,30,30,1,1,1
  ];
  List <int> num = [
    7,20,26,17,25,13,26,1,5,27,23,12,10
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body:  SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            headingRowColor: MaterialStateProperty.all(Colors.blueGrey.shade900),
            border: TableBorder.all(color: Colors.white),

            columns:[
              DataColumn(
                label: Text("Class Name",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              DataColumn(
                label: Text("Count",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              DataColumn(
                label: Text("Registered",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ], rows: classStudents.entries.toList().asMap().entries.map((entry){
              int index = entry.key;
          final className = entry.value.key;
          final students = entry.value.value;
          return DataRow(cells: [
            DataCell(Text(className,
                style:  TextStyle(color: Colors.white))),
            DataCell(Text(count[index].toString(),
                style:  TextStyle(color: Colors.white))),
            DataCell(Text(num[index].toString(),
                style:  TextStyle(color: Colors.white))),
          ]);
        }).toList()),
      )
          );
  }
}
