import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/analytics/student_wise/studentwise_2.dart';

import '../../../../dummydata/datas.dart';
import '../subject_wise/subject_wise2.dart';

class StudentWise extends StatefulWidget {
  const StudentWise({super.key});

  @override
  State<StudentWise> createState() => _StudentWiseState();
}

class _StudentWiseState extends State<StudentWise> {
  String? selectedClass;
  String? selectedExam;
  String? selectedStudent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        body: Padding(
        padding: const EdgeInsets.all(8.0),
    child: Column(mainAxisAlignment: MainAxisAlignment.center,
    children: [
    buildRowDropDown(
    "Select Class                 :","Select Class",
    selectedClass,
    list,
    (value) {
    setState(() => selectedClass = value);
    },
    ),
    SizedBox(height: 10,),
    buildRowDropDown(
    "Select Exam                 :","Select Exam",
    selectedExam,
    exams,
    (value) {
    setState(() => selectedExam = value);
    },
    ),
    SizedBox(height: 10,),
      buildRowDropDown(
        "Select Student             :","Select Student",
        selectedStudent,
        selectedClass != null ? (classStudents[selectedClass] ??[]) : [],
            (value) {
          setState(() => selectedStudent = value);
        },
      ),
      SizedBox(height: 20),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white),
        ),
        onPressed: (){
          if(selectedStudent == null || selectedClass == null || selectedExam == null){
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Please Select Class,Exam and Student")),
    );
    }else{
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Studentwise2()));                        }
        },
        child: const Text("SUBMIT"),
      ),
    ]
    )
        ))
    ;
  }
}
Widget buildRowDropDown(
    String title,
    String hintText,
    String? selectedValue,
    List<String> items,
    ValueChanged<String?> onChanged,
    ) {
  return Row(
    children: [
      Expanded(
        flex: 5,
        child: Text(title, style: TextStyle(color: Colors.white,fontSize: 16)),
      ),
      Expanded(
        flex: 5,
        child: DropdownButtonFormField<String>(
          value: selectedValue,
          isExpanded: true,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(color: Colors.black)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    ],
  );
}