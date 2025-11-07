import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/marks/marks_details/marks_details2.dart';

import '../../../../dummydata/datas.dart';

class MarksDetails extends StatefulWidget {
  const MarksDetails({super.key});

  @override
  State<MarksDetails> createState() => _MarksDetailsState();
}

class _MarksDetailsState extends State<MarksDetails> {
  String? selectedClass;
  String? selectedStudent;
  String? selectedExam;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildRowDropDown(
              "Select Class                 :","Select Class",
              selectedClass,
              list,
                  (value) {
                setState(() => selectedClass = value);
              },
            ),
            SizedBox(height: 15),
            buildRowDropDown(
              "Select Student             :","Select Student",
              selectedStudent,
              selectedClass != null ? (classStudents[selectedClass] ??[]) : [],
                  (value) {
                setState(() => selectedStudent = value);
              },
            ),
            SizedBox(height: 15,),
            buildRowDropDown(
              "Select Exam                 :","Select Exam",
              selectedExam,
              exams,
                  (value) {
                setState(() => selectedExam = value);
              },
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                if (
                selectedClass == null ||
                    selectedStudent == null || selectedStudent == null
                ) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                    Text( "Please fill all fields!")));
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MarksDetails2(studentName: selectedStudent!, selectedClass: selectedClass!, selectedExam: selectedExam!,)));
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.blueGrey.shade900,
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white, width: 2),
              ),
              child: const Text("SUBMIT"),
            ),
          ],
        ),
      ),

    );
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