import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/remarks/add_remarks/add_remarks.dart';
import 'package:raynottschool/screens/categories/remarks/view_remarks/view_remakrs.dart';

import '../../../dummydata/datas.dart';

class Remarks extends StatefulWidget {
  const Remarks({super.key});

  @override
  State<Remarks> createState() => _RemarksState();
}

class _RemarksState extends State<Remarks> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
      Row(
      children: [
      Expanded(
      flex: 4,
        child: Text(
          "Class Name",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),),
      Expanded(
        flex: 5,
        child: DropdownButtonFormField<String>(
          value: selectedValue,
          isExpanded: true,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
          items: list
              .map((e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e, style: TextStyle(color: Colors.black)),
          ))
              .toList(),
          onChanged: (value){
            selectedValue = value;
          },
        ),
      ),
      ],
      ),
          SizedBox(height: 20,),
          Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if(selectedValue ==null ){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select class")));
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewRemakrs(selectedStudent: selectedValue!)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade900,
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("VIEW REMARKS", style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 20,) ,
                ElevatedButton(
                  onPressed: () {
                    if(selectedValue ==null ){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select class")));
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AddRemarks(selectedStudent: selectedValue!, selectedClass: selectedValue!,)));

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade900,
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("ADD REMARKS", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
