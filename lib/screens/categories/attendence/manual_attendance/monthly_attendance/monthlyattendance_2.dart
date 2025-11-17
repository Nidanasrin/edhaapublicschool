import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/attendence/manual_attendance/monthly_attendance/manualattendance_details.dart';

class Monthlyattendance2 extends StatefulWidget {
  final String className;
  final List<String> students;
  final String date;

  const Monthlyattendance2({super.key, required this.className, required this.students, required this.date});


  @override
  State<Monthlyattendance2> createState() => _Monthlyattendance2State();
}

class _Monthlyattendance2State extends State<Monthlyattendance2> {
String searchQuery = "";


  @override
  Widget build(BuildContext context) {
    final filteredStudents= widget.students.where((student)=> student.toLowerCase().contains(searchQuery.toLowerCase())).toList();
    return Scaffold(backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(backgroundColor: Colors.blueGrey.shade900,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text("Class : ", style: TextStyle(fontSize: 15,color: Colors.white)),
            Text(
              widget.className,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),actions: [
          Row(
            children: [
              Text("Date : ", style: TextStyle(fontSize: 16,color: Colors.white)),
              Text(
                widget.date,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ],
          ),
      ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Student Name",
                  prefixIcon: Icon(Icons.search,color: Colors.grey,),
                  border: InputBorder.none,
                ),onChanged: (value){
                  setState(() {
                    searchQuery = value;
                  });
              },
              ),
            ),
            SizedBox(height: 10,),
            Expanded(child: ListView.separated(itemBuilder: (context,index){
return ListTile(
  onTap: (){
    final date = widget.date;
Navigator.push(context, MaterialPageRoute(builder: (context)=> ManualattendanceDetails(studentName: filteredStudents[index], date: date,)));
  },
  title: Text(filteredStudents[index],style: TextStyle(color: Colors.white),),
);
            }, separatorBuilder: (context, index) =>
                Divider(thickness: 0.5, height: 0, color: Colors.grey),
              itemCount: filteredStudents.length,)),
            // Expanded(
            //   child: ListView.separated(itemBuilder: (context,index){
            //     return ListTile(
            //       title: Text("${widget.students}"),
            //     );
            //   }, separatorBuilder: (context,index)=>Divider(thickness: 0.5, height: 0,), itemCount: widget.students.length),
            // )
          ],
        ),
      ),
    );
  }
}
