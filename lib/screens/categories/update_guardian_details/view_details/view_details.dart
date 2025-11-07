import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/update_guardian_details/view_details/view_details2.dart';

import '../../../../dummydata/datas.dart';

class ViewDetails extends StatefulWidget {
final String selectedClass;

  const ViewDetails({super.key, required this.selectedClass});
  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  @override
  Widget build(BuildContext context) {
    final student = classStudents[widget.selectedClass] ?? [];

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        children: [
          Expanded(child: ListView.separated(itemBuilder: (context,index){
            final studentName= student[index];
            return ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewDetails2(selectedStudent: studentName, selectedClass: widget.selectedClass)));
              },
              title: Text(studentName,style: TextStyle(color: Colors.white),),
            );
          }, separatorBuilder: (context,index)=> Divider(color: Colors.white,thickness: 1,height: 0,), itemCount: student.length))
        ],
      ),
    );
  }
}
