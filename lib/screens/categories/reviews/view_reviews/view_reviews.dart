import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'package:raynottschool/screens/categories/reviews/view_reviews/no_review.dart';

class ViewReviews extends StatefulWidget {
final String selectedStudent;

  const ViewReviews({super.key, required this.selectedStudent});
  @override
  State<ViewReviews> createState() => _ViewReviewsState();
}

class _ViewReviewsState extends State<ViewReviews> {
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
    Navigator.push(context, MaterialPageRoute(builder: (context)=> NoReview()));
  },
  title: Text(studentName,style: TextStyle(color: Colors.white),),
);
          }, separatorBuilder: (context,index)=> Divider(color: Colors.white,thickness: 1,height: 0,), itemCount: student.length))
        ],
      ),
    );
  }
}
