import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/marks/marks_insertion/mark_insertion2.dart';

import '../../../../dummydata/datas.dart';

class MarksInsertions extends StatefulWidget {
  const MarksInsertions({super.key});

  @override
  State<MarksInsertions> createState() => _MarksInsertionsState();
}

class _MarksInsertionsState extends State<MarksInsertions> {
  String? selectedClass;
  String? selectedExam;

  void msgBox(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text("Message"),
          content: Text("Subjects not yet mapped for these Exam"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
          ],
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueGrey.shade900,
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildRowDropDown(
                      "Select Class                :","Select Class",
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
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(5)),
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white,width: 2),
                      ),
                      onPressed: (){
                        if(selectedClass==null || selectedExam == null){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please fill all the details")),
                          );
                        }else{
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> MarkInsertion2(selectedClass: selectedClass!, selectedExam: selectedExam!)));
                        }
                      },
                      child: const Text("SUBMIT"),
                    ),
                  ])
          ),
        )
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


