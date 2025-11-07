import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/achievements/add_achievements/add_achievements2.dart';

import '../../../../dummydata/datas.dart';

class AddAchievements extends StatefulWidget {
  final String selectedStudent;
  final String selectedClass;

  const AddAchievements({super.key, required this.selectedStudent, required this.selectedClass});

  @override
  State<AddAchievements> createState() => _AddAchievementsState();
}

class _AddAchievementsState extends State<AddAchievements> {
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
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddAchievements2(selectedStudent: widget.selectedStudent, selectedClass: widget.selectedClass)));
        },
        title: Text(studentName,style: TextStyle(color: Colors.white),),
      );
    }, separatorBuilder: (context,index)=> Divider(color: Colors.white,thickness: 1,height: 0,), itemCount: student.length))
    ],
    ),
    );
    }
}
