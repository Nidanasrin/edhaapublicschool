import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/attendence/face_attendance/face_attendence.dart';
import 'package:raynottschool/screens/categories/attendence/face_attendance/facemapping_details.dart';

import '../../../../dummydata/datas.dart';

class FaceMapping extends StatefulWidget {
  const FaceMapping({super.key});

  @override
  State<FaceMapping> createState() => _FaceMappingState();
}

class _FaceMappingState extends State<FaceMapping> {
  String? selectedValue;
  void dialogBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        title: Text("Message", style: TextStyle(color: Colors.black)),
        content: Text("Face ID Generation Submitted Successfully"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.indigo.shade900,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.indigo.shade900,

                ),
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> FaceAttendence()));
                },
                child: const Text(
                  'OK',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(height: 40.0,),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape:
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.white,width: 2),
                      ),backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white
                  ),
                  onPressed: (){
                    if(selectedValue != null){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> FacemappingDetails()));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Select An Option")));
                    }
                  }, child: Text("SUBMIT")),
            ),
SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                dialogBox();
              },
              child: Center(
                child: CircleAvatar(radius: 60,
                  backgroundColor: Colors.blue.shade600,
                  child: Text("FACE ID GENERATION",style: TextStyle(color: Colors.white,fontSize: 16),textAlign: TextAlign.center,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
