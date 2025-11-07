import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/remarks/view_remarks/no_remarks.dart';

import '../../../../dummydata/datas.dart';

class ViewRemakrs extends StatefulWidget {
final String selectedStudent;

  const ViewRemakrs({super.key, required this.selectedStudent});
  @override
  State<ViewRemakrs> createState() => _ViewRemakrsState();
}

class _ViewRemakrsState extends State<ViewRemakrs> {
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=> NoRemarks()));
              },
              title: Text(studentName,style: TextStyle(color: Colors.white),),
            );
          }, separatorBuilder: (context,index)=> Divider(color: Colors.white,thickness: 1,height: 0,), itemCount: student.length))
        ],
      ),
    );
  }
}

