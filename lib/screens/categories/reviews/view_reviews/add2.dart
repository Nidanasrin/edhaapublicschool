import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'package:raynottschool/screens/categories/reviews/view_reviews/add_review.dart';

class Add2 extends StatefulWidget {
  final String selectedStudent;
  final String selectedClass;

  const Add2({super.key, required this.selectedStudent, required this.selectedClass});
  @override
  State<Add2> createState() => _Add2State();
}

class _Add2State extends State<Add2> {
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AddReview(selectedStudent: studentName, selectedClass: widget.selectedClass)));
              },
              title: Text(studentName,style: TextStyle(color: Colors.white),),
            );
          }, separatorBuilder: (context,index)=> Divider(color: Colors.white,thickness: 1,height: 0,), itemCount: student.length))
        ],
      ),
    );
  }
}
