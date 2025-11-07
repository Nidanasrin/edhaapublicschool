import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/behaviour_management/behaviour_list_screen3.dart';

import '../../../dummydata/datas.dart';

class BehaviourListScreen2 extends StatefulWidget {
  final String selectedClass;

  const BehaviourListScreen2({super.key, required this.selectedClass});

  @override
  State<BehaviourListScreen2> createState() => _BehaviourListScreen2State();
}

class _BehaviourListScreen2State extends State<BehaviourListScreen2> {
  TextEditingController searchController = TextEditingController();
  List<String> filteredStudents = [];

  @override
  void initState() {
    super.initState();
    filteredStudents = classStudents[widget.selectedClass] ?? [];
  }

  void msgBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: Colors.white,
        title: Text("Message"),
        content: Text("Please map exams and subjects"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK", style: TextStyle(color: Colors.indigo.shade900)),
          ),
        ],
      ),
    );
  }

  void searchStudent(String query) {
    final allStudents = classStudents[widget.selectedClass] ?? [];
    setState(() {
      filteredStudents = allStudents
          .where((name) => name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueGrey.shade900,foregroundColor: Colors.white,),
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Text(
            widget.selectedClass,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 17),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: TextField(
              controller: searchController,
              onChanged: searchStudent,
              decoration: InputDecoration(
                hintText: "Search Student Name",
                hintStyle: TextStyle(color: Colors.grey),
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    searchController.clear();
                    searchStudent('');
                  },
                  icon: Icon(Icons.close),
                ),
              ),
            ),
          ),
      SizedBox(height: 10),
      Expanded(
        child: filteredStudents.isEmpty
            ? const Center(
          child: Text(
            "No students found",
            style: TextStyle(color: Colors.white70),
          ),
        )
            :
          ListView.separated(itemBuilder: (context,index){
final studentName = filteredStudents[index];
return ListTile(
  onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=> BehaviourListScreen3()));
  },
title: Text(
studentName,
style: const TextStyle(color: Colors.red,fontSize: 16),
            ),
);
          }, separatorBuilder: (context,index)=> Divider(thickness: 1,height: 0,), itemCount: filteredStudents.length)
      )
        ],
      ),
    );
  }
}
