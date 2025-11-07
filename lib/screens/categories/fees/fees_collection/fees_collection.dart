import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/fees/fees_collection/fee_collection_details.dart';

import '../../../../dummydata/datas.dart';

class FeesCollection extends StatefulWidget {
  const FeesCollection({super.key});

  @override
  State<FeesCollection> createState() => _FeesCollectionState();
}

class _FeesCollectionState extends State<FeesCollection> {
  String? selectedYear;
  String? selectedClass;
  String? selectedStudent;
  bool isVisible = false;
  List<String> studentList = [];
  @override
  void initState() {
    super.initState();
    selectedYear = "2025-26";
    selectedClass = "NURSERY";
    studentList = classStudents[selectedClass] ?? [];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Academic year
              SizedBox(height: 50,),
              Row(
                children: [
                   Expanded(
                    flex: 4,
                    child: Text(
                      "Select Academic Year:",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
              ),
                  Expanded(
                    flex: 5,
                    child: DropdownButtonFormField<String>(
                      value: selectedYear,
                      isExpanded: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      items: year.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
               SizedBox(height: 20),
              Row(
              children: [
              Expanded(flex: 4,child: Text("Class name       :",style: TextStyle(color: Colors.white,fontSize: 18),)),
              Expanded(flex: 5,
              child: DropdownButtonFormField<String>(
              value: selectedClass,isExpanded: true,
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
              selectedClass = value;
              });
              }),
              ),
              ]
              ),
              // Organization Name

               SizedBox(height: 20),
          Row(
              children: [
                Expanded(flex: 4,child: Text("Select Student       :",style: TextStyle(color: Colors.white,fontSize: 18),)),
                Expanded(flex: 5,
                  child: DropdownButtonFormField<String>(
                      value: selectedStudent,isExpanded: true,
                      decoration: InputDecoration(fillColor: Colors.white,
                          filled: true,hintText: "Select Student",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                      items: studentList.map((String value){
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style: TextStyle(color: Colors.black),)
                        );
                      }).toList(),
                      onChanged: (value){
                        setState(() {
                          selectedStudent = value;
                        });
                      }),
                ),
              ]
          ),

               SizedBox(height: 20),

              // Submit button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                    backgroundColor: Colors.blueGrey.shade900,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                  if(selectedStudent == null || selectedStudent!.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please Select A Student")));
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> FeeCollectionDetails()));
                    }
                  },
                  child: const Text("SUBMIT"),
                ),
              ),
              const SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Parents Fees Visibility",style: TextStyle(color: Colors.white,fontSize: 17),),
                  Switch(
                    activeThumbColor: Colors.pink,
                      value: isVisible, onChanged: (value){
                      setState(() {
                        isVisible = value;
                      });

                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

