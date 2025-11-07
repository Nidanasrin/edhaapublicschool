import 'package:flutter/material.dart';

class ViewDetails2 extends StatefulWidget {
final String selectedStudent;
final String selectedClass;

  const ViewDetails2({super.key, required this.selectedStudent, required this.selectedClass});
  @override
  State<ViewDetails2> createState() => _ViewDetails2State();
}

class _ViewDetails2State extends State<ViewDetails2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
        Row(
          children: [
        Expanded(
          flex: 3,
          child: Text("Student Name", style: TextStyle(color: Colors.white,fontSize: 16)),
        ),
        Expanded(
          flex: 3,
          child: Text(":  ${widget.selectedStudent}",style: TextStyle(color: Colors.white,fontSize: 16),),
        ),
            ]
        ),
            SizedBox(height: 15,),
            Row(
              children: [
            Expanded(
              flex: 3,
              child: Text("Class Name", style: TextStyle(color: Colors.white,fontSize: 16)),
            ),
            Expanded(
              flex: 3,
              child: Text(":  ${widget.selectedClass}",style: TextStyle(color: Colors.white,fontSize: 16),),
            ),
          ],
        ),
        ]
      ),
      )
    );
  }
}
