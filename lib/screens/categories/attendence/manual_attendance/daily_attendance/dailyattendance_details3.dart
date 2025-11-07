import 'package:flutter/material.dart';

class DailyattendanceDetails3 extends StatefulWidget {
  final Set<int> absentees;
  final List<String> students;

  const DailyattendanceDetails3({super.key, required this.absentees, required this.students});

  @override
  State<DailyattendanceDetails3> createState() => _DailyattendanceDetails3State();
}

class _DailyattendanceDetails3State extends State<DailyattendanceDetails3> {
  @override
  Widget build(BuildContext context) {
    int totalStudents = widget.students.length;
    int absentCount = widget.absentees.length;
    int presentCount = totalStudents - absentCount;
    return Scaffold(backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(backgroundColor: Colors.blueGrey.shade900,
        title: Text("Attendance Report",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold,color: Colors.white),),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: Text("Total Students",style: TextStyle(color: Colors.white,fontSize: 17),)),
                Expanded(child: Text(":   $totalStudents",style: TextStyle(color: Colors.white,fontSize: 17),))
              ],
            ),SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: Text("Total Students",style: TextStyle(color: Colors.white,fontSize: 17),)),
                Expanded(child: Text(":   $presentCount",style: TextStyle(color: Colors.white,fontSize: 17),))
              ],
            ),
            SizedBox(height: 20,),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: Text("Total Students",style: TextStyle(color: Colors.white,fontSize: 17),)),
                Expanded(child: Text(":   $absentCount",style: TextStyle(color: Colors.white,fontSize: 17),))
              ],
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            SizedBox(height: 40,),
            Center(
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/images/app_sms.png",height: 30,),
                  ),SizedBox(width: 40,),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/images/phone.png",height: 40,),
                  ),SizedBox(width: 40,),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/images/bell (1).png",height: 30,),
                  )
                ],
              ),
            )
          ],
        ),
    ]
        )
      ),
    );
  }
}
