import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/documents/other_documents/add_documents/add_documents2.dart';
import '../../../../../../dummydata/datas.dart';

class AddDocuments extends StatefulWidget {
  final String selectedStudent;
  final String selectedClass;

  const AddDocuments({super.key, required this.selectedStudent, required this.selectedClass});

  @override
  State<AddDocuments> createState() => _AddDocumentsState();
}

class _AddDocumentsState extends State<AddDocuments> {
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AddDocuments2(selectedStudent: studentName, selectedClass: widget.selectedClass)));
              },
              title: Text(studentName,style: TextStyle(color: Colors.white),),
            );
          }, separatorBuilder: (context,index)=> Divider(color: Colors.white,thickness: 1,height: 0,), itemCount: student.length))
        ],
      ),
    );
  }
}

