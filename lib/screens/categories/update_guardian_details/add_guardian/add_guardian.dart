import 'package:flutter/material.dart';

import '../../../../dummydata/datas.dart';

class AddGuardian extends StatefulWidget {
final String selectedClass;
final String? selectedStudent;
final Function(String)? onStudentSelected; // callback

  const AddGuardian({super.key, required this.selectedClass, this.onStudentSelected, this.selectedStudent});
  @override
  State<AddGuardian> createState() => _AddGuardianState();
}

class _AddGuardianState extends State<AddGuardian> {

  List<String> guardians = [
    "Father",
    "Mother",
    "Brother",
    "Sister",
    "Uncle",
    "Aunt",
    "Grand Father",
    "Grand Mother",
    "Other"
  ];

  String? selectedGuardian;
  final TextEditingController guardianNameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  void addGuardian(String studentName){
    showDialog(context: context, builder: (context)=>
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)
      ),
      backgroundColor: Colors.blueGrey.shade800,
      content: Column(mainAxisSize: MainAxisSize.min,
        children: [
      Row(
      children: [
      Expanded(flex: 1,
          child: Text("Student Name",style: TextStyle(color: Colors.white,fontSize: 15),)),
      Expanded(child: Text(studentName,style: TextStyle(color: Colors.white,fontSize: 15),))
      ],
    ),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(flex: 1,
                  child: Text("Class Name",style: TextStyle(color: Colors.white,fontSize: 15),)),
              Expanded(child: Text(widget.selectedClass,style: TextStyle(color: Colors.white,fontSize: 15),))
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
          Expanded(
            flex: 5,
            child: Text("Add Guardian", style: TextStyle(color: Colors.white,fontSize: 16)),
          ),
          Expanded(
            flex: 5,
            child: DropdownButtonFormField<String>(
              value: selectedGuardian,
              isExpanded: true,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: "Guardian",
                contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              items: guardians.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
              onChanged: (value){

              },
            ),
          ),
          ]
          ),
          SizedBox(height: 10,),
          Row(
            children: [
          Expanded(flex: 1,
              child: Text("Guardian Name",style: TextStyle(color: Colors.white,fontSize: 15),)),
          Expanded(child: TextField(controller: guardianNameController,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              filled: true,
              hintText: "Guardian Name",
              hintStyle: TextStyle(color: Colors.grey),
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),)),
          ]
          ),
          SizedBox(height: 10,),
          Row(
            children: [
          Expanded(flex: 1,
              child: Text("Contact No",style: TextStyle(color: Colors.white,fontSize: 15),)),
          Expanded(child: TextField(controller: contactController,
            keyboardType: TextInputType.phone,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              filled: true,
              hintText: "Contact No",
              hintStyle: TextStyle(color: Colors.grey),
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),)),
          SizedBox(height: 10,),
        ],
      ),
          SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              if (selectedGuardian == null ||
                  contactController.text.isEmpty ||
                  guardianNameController.text.isEmpty
                   ) {
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
    content:
    Text("Please fill all the details"),
    ),
    );
    } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Guardian Details updated successfully!"),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              backgroundColor: Colors.blueGrey.shade800,
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.white, width: 2),
            ),
            child: const Text("SUBMIT"),
          ),
      ]
      ),
    ));
  }
  @override
  Widget build(BuildContext context) {
    final student = classStudents[widget.selectedClass] ?? [];

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        children: [
          Expanded(child: ListView.separated(itemBuilder: (context,index){
            final studentName= student[index];
            return ListTile(
              onTap: (){
                if (widget.onStudentSelected != null) {
                  addGuardian(studentName);
                }
              },
              title: Text(studentName,style: TextStyle(color: Colors.white),),
            );
          }, separatorBuilder: (context,index)=> Divider(color: Colors.white,thickness: 1,height: 0,), itemCount: student.length))
        ],
      ),
    );
  }
}
