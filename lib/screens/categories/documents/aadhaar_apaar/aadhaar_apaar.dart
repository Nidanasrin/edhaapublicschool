import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/documents/aadhaar_apaar/aadhaar_number.dart';
import 'package:raynottschool/screens/categories/documents/aadhaar_apaar/apaar_number.dart';

import '../../../../dummydata/datas.dart';

class AadhaarApaar extends StatefulWidget {
  const AadhaarApaar({super.key});

  @override
  State<AadhaarApaar> createState() => _AadhaarApaarState();
}

class _AadhaarApaarState extends State<AadhaarApaar> {
  String? selectedClass;
  String? selectedOption;
  List <String> options = [
    "Aadhaar Number",
    "Apaar ID"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
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
                    value: selectedClass,
                    isExpanded: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Class Name",
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
                      selectedClass = value;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text("Select", style: TextStyle(color: Colors.white,fontSize: 16)),
                ),
                Expanded(
                  flex: 5,
                  child: DropdownButtonFormField<String>(
                    value: selectedOption,
                    isExpanded: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Select',
                      contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    items: options.map((String student) {
                      return DropdownMenuItem<String>(
                        value: student,
                        child: Text(student, style: TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                    onChanged: (value){
                      selectedOption = value;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                if (selectedOption == null || selectedClass == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select both student and class")),
                  );
                  return;
                }

                // Check based on actual condition
                if (selectedOption == "Aadhaar Number") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AadhaarNumber(
                        selectedClass: selectedClass!, selectedOption: selectedOption!,
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ApaarNumber(
                        selectedClass: selectedClass!, selectedOption: selectedOption!,
                      ),
                    ),
                  );
                }
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
          ],
        ),
      ),
    );
  }
}

