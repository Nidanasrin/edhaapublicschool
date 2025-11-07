import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/update_guardian_details/add_guardian/add_guardian.dart';
import 'package:raynottschool/screens/categories/update_guardian_details/view_details/view_details.dart';

import '../../../dummydata/datas.dart';

class UpdateGuardianDetails extends StatefulWidget {
  const UpdateGuardianDetails({super.key});

  @override
  State<UpdateGuardianDetails> createState() => _UpdateGuardianDetailsState();
}

class _UpdateGuardianDetailsState extends State<UpdateGuardianDetails> {
  String? selectedClass;

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
                  child: Text("Class Name", style: TextStyle(color: Colors.white, fontSize: 16)),
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
                    items: list.map((value) => DropdownMenuItem(
                      value: value,
                      child: Text(value, style: TextStyle(color: Colors.black)),
                    )).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedClass = value; // Update UI
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (selectedClass == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please select class"))
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewDetails(selectedClass: selectedClass!),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade900,
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text("VIEW DETAILS"),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedClass == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please select class"))
                        );
                        return;
                      }
                      // Navigate directly to AddGuardian to select a student
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddGuardian(
                            selectedClass: selectedClass!,
                            onStudentSelected: (studentName) {
                              // Show dialog for guardian after selecting student
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddGuardian(
                                    selectedClass: selectedClass!,
                                    selectedStudent: studentName,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade900,
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text("ADD DETAILS"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
