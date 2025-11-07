import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'admission_details.dart';
import 'hallticket_details.dart';

class AdmissionHallticketInfo extends StatefulWidget {
  const AdmissionHallticketInfo({super.key});

  @override
  State<AdmissionHallticketInfo> createState() =>
      _AdmissionHallticketInfoState();
}

class _AdmissionHallticketInfoState extends State<AdmissionHallticketInfo> {
  String? selectedClass;
  String? selectedOption;

  List<String> options = [
    "Admission Number",
    "Hall Ticket Number",
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
            // Class Dropdown
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    "Class Name",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
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
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 5, vertical: 3),
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
                    onChanged: (value) {
                      setState(() {
                        selectedClass = value;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Option Dropdown
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    "Select Option",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: DropdownButtonFormField<String>(
                    value: selectedOption,
                    isExpanded: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Select Option',
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    items: options.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option, style: TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                if (selectedClass == null || selectedOption == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Please select both class and option")),
                  );
                  return;
                }

                if (selectedOption == "Admission Number") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AdmissionDetails(
                        selectedClass: selectedClass!,
                        selectedOption: selectedOption!,
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          HallticketDetails(selectedClass: selectedClass!),
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
