import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'package:raynottschool/screens/categories/create_classes/promote_students/promote_students_2.dart';

class PromoteStudents extends StatefulWidget {
  const PromoteStudents({super.key});

  @override
  State<PromoteStudents> createState() => _PromoteStudentsState();
}

class _PromoteStudentsState extends State<PromoteStudents> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Row(
        children: [
        Expanded(
        flex: 5,
          child: Text("Select Class", style: TextStyle(color: Colors.white,fontSize: 16)),
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
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(5)),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white,width: 2),
              ),
              onPressed: (){
                if(selectedValue==null){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill all the details")),
                  );
                }else{
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PromoteStudents2()));
                }
              },
              child: const Text("SUBMIT"),
            ),
          ],
        ),
      ),
    );
  }
}
