import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';

class StudentwiseReport extends StatefulWidget {
final String selectedClass;

  const StudentwiseReport({super.key, required this.selectedClass});
  @override
  State<StudentwiseReport> createState() => _StudentwiseReportState();
}

class _StudentwiseReportState extends State<StudentwiseReport> {

  @override
  Widget build(BuildContext context) {
    final List<String> students = classStudents[widget.selectedClass] ?? [];
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        children: [
          SizedBox(height: 30,),
          Expanded(
            child: ListView.separated(itemBuilder: (context,index){
              final name = students[index];
              return ListTile(
                title: Text(name,style: TextStyle(color: Colors.red.shade800,fontWeight: FontWeight.bold),),
              );
            }, separatorBuilder: (context,index)=>Divider(height: 0,thickness: 1,color: Colors.white,), itemCount: widget.selectedClass.length),
          )
        ],
      ),
    );
  }
}
