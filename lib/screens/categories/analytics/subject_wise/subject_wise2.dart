import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'package:raynottschool/screens/categories/analytics/subject_wise/subject_wise3.dart';

class SubjectWise2 extends StatefulWidget {
  const SubjectWise2({super.key});

  @override
  State<SubjectWise2> createState() => _SubjectWise2State();
}

class _SubjectWise2State extends State<SubjectWise2> {
  String? selectedSub;

  void msgBox(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text("Message"),
          content: Text("Please Select Subject",style: TextStyle(fontSize: 16),),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text

              ("OK",style: TextStyle(color: Colors.indigo.shade900),))
          ],
        )
    );
  }
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
          child: Text("Select Subject              :", style: TextStyle(color: Colors.white,fontSize: 16)),
        ),
        Expanded(
          flex: 5,
          child: DropdownButtonFormField<String>(
            value: selectedSub,
            isExpanded: true,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "Select Subject",
              contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            items: subjects.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.black)),
              );
            }).toList(),
            onChanged: (value){
              selectedSub = value;
            },
          ),
        ),
        ],
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(5)),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white,width: 2),
              ),
              onPressed: (){
                if(selectedSub==null){
                 msgBox();
                }else{
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SubjectWise3()));
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
