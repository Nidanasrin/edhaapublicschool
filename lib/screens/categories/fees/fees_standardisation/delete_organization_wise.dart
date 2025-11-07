import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/fees/fees_standardisation/delete_org_wise_details.dart';

import '../../../../dummydata/datas.dart';

class DeleteOrganizationWise extends StatefulWidget {
  const DeleteOrganizationWise({super.key});

  @override
  State<DeleteOrganizationWise> createState() => _DeleteOrganizationWiseState();
}

class _DeleteOrganizationWiseState extends State<DeleteOrganizationWise> {
  String? selectedYear;
  TextEditingController orgController =
  TextEditingController(text: "EDHAA PUBLIC SCHOOL");

  @override
  void initState() {
    super.initState();
    selectedYear = "2025-26";
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Academic year
              SizedBox(height: 50),
              Row(
                children: [
                  const Expanded(
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
              const SizedBox(height: 20),

              // Organization Name
              Row(
                children: [
                  const Expanded(
                    flex: 4,
                    child: Text(
                      "Organization Name:",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: TextField(
                      controller: orgController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Submit button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                   if(selectedYear!= null && orgController.text.isNotEmpty){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  DeleteOrgWiseDetails(feeDetails: organizationWiseData
                              .where((org) =>
                          org["year"] == selectedYear &&
                              org["organization"] == orgController.text)
                              .toList(), ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please fill the Options")),
                      );
                    }
                  },
                  child: const Text("SUBMIT"),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
