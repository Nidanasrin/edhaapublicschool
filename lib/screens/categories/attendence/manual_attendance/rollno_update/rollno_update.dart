import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'package:raynottschool/screens/categories/attendence/manual_attendance/rollno_update/studentsListPage.dart';

class RollnoUpdate extends StatefulWidget {
  const RollnoUpdate({super.key});

  @override
  State<RollnoUpdate> createState() => _RollnoUpdateState();
}

class _RollnoUpdateState extends State<RollnoUpdate> {
  String? selectedValue;

  List<String> getStudents(String className){
    switch(className){
      case "NURSERY":
        return nursery;
      case "LKG":
        return lkg;
      case "UKG":
        return ukg;
      case "GRADE-1":
        return grade1;
      case "GRADE-2":
        return grade2;
      case "GRADE-3":
        return grade3;
      case "GRADE-4":
        return grade4;
      case "GRADE-5":
        return grade5;
      case "GRADE-6":
        return grade6;
      case "GRADE-7":
        return grade7;
      case "DAY CARE":
        return daycare;
      case "GRADE 7 STATE SYLLABUS":
        return grade7;
      case "GRADE 8 STATE SYLLABUS":
        return grade8State;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
            Expanded(flex: 4,child: Text("Class name       :",style: TextStyle(color: Colors.white,fontSize: 18),)),
            Expanded(flex: 5,
              child: DropdownButtonFormField<String>(
                value: selectedValue,isExpanded: true,
                decoration: InputDecoration(fillColor: Colors.white,
                filled: true,hintText: "Select Class",
                border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(5),
                )),
                  items: list.map((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                        child: Text(value,style: TextStyle(color: Colors.black),)
                    );
                  }).toList(),
                  onChanged: (value){
                  setState(() {
                    selectedValue = value;
                  });
              }),
            ),
            ]
            ),
            SizedBox(height: 20.0,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape:
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.white,width: 2),
                  ),backgroundColor: Colors.transparent,
                foregroundColor: Colors.white
              ),
                onPressed: (){
                if(selectedValue != null){
                  final students = getStudents(selectedValue!);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Studentslistpage(className: selectedValue!, students: students)));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Select a Class.")));
                }
                }, child: Text("SUBMIT"))

          ],
        ),
      ),
    );
  }
}
