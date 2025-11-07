import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'package:raynottschool/screens/categories/students_details/student_details2.dart';

class StudentsDetails extends StatefulWidget {
  const StudentsDetails({super.key});

  @override
  State<StudentsDetails> createState() => _StudentsDetailsState();
}

class _StudentsDetailsState extends State<StudentsDetails> {
  String? selectedValue;
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Row(
        children: [
        Expanded(
        flex: 5,
          child: Text("Class Name", style: TextStyle(color: Colors.white,fontSize: 16)),
        ),
        Expanded(
          flex: 5,
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            isExpanded: true,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "Select Class",
              contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            items: list.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.black)),
              );
            }).toList(),
            onChanged: (value){
              selectedValue = value;
            },
          ),
        ),
        ],
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentDetails2(selectedClass: selectedValue!,)));
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
            SizedBox(height: 50,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Student Details Edit Permission",style: TextStyle(color: Colors.white,fontSize: 16),),
                Switch(activeColor: Colors.pink,
                    value: isSwitched, onChanged: (value){
                  setState(() {
                    isSwitched = value;

                  });
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
