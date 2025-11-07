import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'package:raynottschool/screens/categories/marks/marks_insertion/mark_insertiondetails.dart';

class MarkInsertion2 extends StatefulWidget {
final String selectedClass;
final String selectedExam;

  const MarkInsertion2({super.key, required this.selectedClass, required this.selectedExam});
  @override
  State<MarkInsertion2> createState() => _MarkInsertion2State();
}

class _MarkInsertion2State extends State<MarkInsertion2> {
  TextEditingController searchController = TextEditingController();
  List<String> filteredStudents = [];

  @override
  void initState() {
    super.initState();
    filteredStudents = classStudents[widget.selectedClass] ?? [];
    if(filteredStudents.isEmpty){
      msgBox();
    }
  }

  void msgBox(){
    showDialog(context: context, builder: (context)=>
    AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),backgroundColor: Colors.white,title: Text("Message"),content: Text("Please map exams and subjects"),actions: [
      TextButton(onPressed: (){
        Navigator.pop(context);
      }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
    ],));
  }

  void searchStudent(String query){
    final allStudents = classStudents[widget.selectedClass] ?? [];
    setState(() {
      filteredStudents = allStudents.where((name)=> name.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 30),
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
                  suffixIcon: IconButton(onPressed: (){
                    searchController.clear();
                    searchStudent('');
                  }, icon:  Icon(Icons.close),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
        Expanded(
          child: filteredStudents.isEmpty
              ?  Center(
            child: Text(
              "No students found.",
              style: TextStyle(color: Colors.white),
            ),
          )
              :
          ListView.separated(

              itemBuilder: (context,index){
            final studentName = filteredStudents[index];
               return ListTile(
               title: Text(
               studentName,
      style: const TextStyle(color: Colors.white),
      ),onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> MarkInsertiondetails(studentName: studentName, selectedClass: widget.selectedClass, selectedExam: widget.selectedExam,)));
               },
      );
            }, separatorBuilder: (context,index)=> Divider(thickness: 2,height: 0,),
          itemCount: filteredStudents.length)
        )
          ],
        ),
      ),
    );
  }
}
