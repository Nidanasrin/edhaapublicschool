import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'package:raynottschool/screens/categories/behaviour_management/behaviour_list_screen2.dart';

class BehaviourManagement extends StatefulWidget {
  const BehaviourManagement({super.key});

  @override
  State<BehaviourManagement> createState() => _BehaviourManagementState();
}

class _BehaviourManagementState extends State<BehaviourManagement> {
  String? selectedClass;
  void box(){
    showDialog(context: context, builder: (context)=>
    AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(flex: 2,
                child: Text("Select Class      :",style: TextStyle(fontSize: 16),)),
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<String>(
                value: selectedClass,
                isExpanded: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Select Class",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                ),
                items: list
                    .map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e, style: TextStyle(color: Colors.black)),
                ))
                    .toList(),
                onChanged: (value){
                  selectedClass = value;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Center(
          child: ElevatedButton(
            onPressed: () {
              if(selectedClass == null){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select a class")));
              }else{
                Navigator.push(context, MaterialPageRoute(builder: (context)=> BehaviourListScreen2(selectedClass: selectedClass!)));
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.indigo.shade900,
              side: const BorderSide(color: Colors.indigo,width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text("SUBMIT",style: TextStyle(fontWeight: FontWeight.bold),),
          ),
        ),
      ],
    ),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueGrey.shade900,
        body: Center(
        child:  Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
            GestureDetector(
            onTap: (){
              box();
        },
            child:
            Container(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white,width: 2),
              borderRadius:
              BorderRadius.circular(10)),
          child: Text("BEHAVIOUR MANAGEMENT",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
        )
            )
          ]
    )
        )
    );
  }
}
