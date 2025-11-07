import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/remarks/add_remarks/add_remarks2.dart';

import '../../../../dummydata/datas.dart';

class AddRemarks extends StatefulWidget {
  final String selectedStudent;
  final String selectedClass;

  const AddRemarks({super.key, required this.selectedStudent, required this.selectedClass});

  @override
  State<AddRemarks> createState() => _AddRemarksState();
}

class _AddRemarksState extends State<AddRemarks> {
  @override
  Widget build(BuildContext context) {
    final student = classStudents[widget.selectedStudent] ?? [];

    return Scaffold(
    backgroundColor: Colors.blueGrey.shade900,
    body: Column(
    children: [
    Expanded(child: ListView.separated(itemBuilder: (context,index){
      final studentName= student[index];
      return ListTile(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddRemarks2(selectedStudent: studentName, selectedClass: widget.selectedClass)));
        },
        title: Text(studentName,style: TextStyle(color: Colors.white),),
      );
    }, separatorBuilder: (context,index)=> Divider(color: Colors.white,thickness: 1,height: 0,), itemCount: student.length))
    ],
    ),
    );
    }
}
