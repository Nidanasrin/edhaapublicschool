import 'package:flutter/material.dart';

import '../../../../../../dummydata/datas.dart';

class ViewDocuments extends StatefulWidget {
  final String selectedStudent;

  const ViewDocuments({super.key, required this.selectedStudent});

  @override
  State<ViewDocuments> createState() => _ViewDocumentsState();
}

class _ViewDocumentsState extends State<ViewDocuments> {

  void msgbox(){
    showDialog(context: context, builder: (context)=> AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text("Message",style: TextStyle(fontWeight: FontWeight.bold),),
      content: Text("No Documents Found"),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
      ],
    ));
  }
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
msgbox();
},
              title: Text(studentName,style: TextStyle(color: Colors.white),),
            );
          }, separatorBuilder: (context,index)=> Divider(color: Colors.white,thickness: 1,height: 0,), itemCount: student.length))
        ],
      ),
    );
  }
}
