import 'package:flutter/material.dart';

import '../../../../dummydata/datas.dart';

class DeleteConcession extends StatefulWidget {
  const DeleteConcession({super.key});

  @override
  State<DeleteConcession> createState() => _DeleteConcessionState();
}

class _DeleteConcessionState extends State<DeleteConcession> {
  String? selectedYear;
  String? selectedClass;

  @override
  void initState(){
    super.initState();
  selectedYear = "2025-26";
    selectedClass = "NURSERY";

  }
  void msgbox(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text("Message"),
          content: Text("No Concessions Found"),
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
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
      SizedBox(height: 15),
      buildRowDropDown(
        "Select Academic Year               :","Select Year",
        selectedYear,
        year,
            (value) {
          setState(() => selectedYear = value);
        },
      ),
      SizedBox(height: 15),
      buildRowDropDown(
        "Select Class                               :","Select Class",
        selectedClass,
        list,
            (value) {
          setState(() => selectedClass = value);
        },
      ),
          SizedBox(height: 20,),
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
                if (selectedYear == null || selectedClass == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please select an Option"))
                  );
                } else {
                  msgbox();
                }
              },
              child: const Text("SUBMIT"),
            ),
          )
    ])
    );
  }
}

Widget buildRowDropDown(
    String title,String hintText,
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