import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/achievements/view_achievements/no_achievements.dart';

import '../../../../dummydata/datas.dart';

class ViewAchievements extends StatefulWidget {
  final String selectedStudent;

  const ViewAchievements({super.key, required this.selectedStudent});

  @override
  State<ViewAchievements> createState() => _ViewAchievementsState();
}

class _ViewAchievementsState extends State<ViewAchievements> {
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=> NoAchievements()));
              },
              title: Text(studentName,style: TextStyle(color: Colors.white),),
            );
          }, separatorBuilder: (context,index)=> Divider(color: Colors.white,thickness: 1,height: 0,), itemCount: student.length))
        ],
      ),
    );
  }
}

