import 'package:flutter/material.dart';

import '../../../../dummydata/datas.dart';

class CreateOrganizationWise extends StatefulWidget {
  const CreateOrganizationWise({super.key});

  @override
  State<CreateOrganizationWise> createState() => _CreateOrganizationWiseState();
}

class _CreateOrganizationWiseState extends State<CreateOrganizationWise> {
  String? selectedYear;
  TextEditingController orgController =
  TextEditingController(text: "EDHAA PUBLIC SCHOOL");

  // Fee type and amount entries
  List<Map<String, dynamic>> feeEntries = [];


  @override
  void initState() {
    super.initState();
    selectedYear = "2025-26";

    // Add one initial fee type row
    feeEntries.add({
      "type": "SCHOOL FEE",
      "controller": TextEditingController(),
    });
  }

  /// Add new fee field
  void addField() {
    setState(() {
      feeEntries.add({
        "type": "SCHOOL FEE",
        "controller": TextEditingController(),
      });
    });
  }

  /// Remove fee field
  void removeField(int index) {
    setState(() {
      feeEntries.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Academic year
            SizedBox(height: 50,),
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
                    )),
                Expanded(
                  flex: 5,
                  child: TextField(
                    controller: orgController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Header Row
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: Colors.green.shade700,
              ),
              width: double.infinity,
              child: const Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: Text("Select Fees Type",
                          style: TextStyle(color: Colors.white))),
                  Expanded(
                      flex: 4,
                      child:
                      Text("Amount", style: TextStyle(color: Colors.white))),
                ],
              ),
            ),
            const SizedBox(height: 10), GestureDetector(
              onTap: addField,
              child: Row(
                children: const [
                  Icon(Icons.add_circle, color: Colors.blue),
                  SizedBox(width: 6),
                  Text(
                    "ADD FEES TYPES",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            // Dynamic fee rows
            Expanded(
              child: ListView.builder(
                itemCount: feeEntries.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: DropdownButtonFormField<String>(
                            value: feeEntries[index]["type"],
                            isExpanded: true,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            items: feeTypes.map((String type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                feeEntries[index]["type"] = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10),

                        Expanded(
                          flex: 4,
                          child: TextField(
                            controller: feeEntries[index]["controller"],
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: "Amount",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: () => removeField(index),
                          child: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Add Fees Button

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
                  bool valid = feeEntries
                      .any((entry) => entry["controller"].text.isNotEmpty);

                  if (valid) {
                    organizationWiseData.add({
                         "year" : selectedYear,
                       "organization" : orgController.text,
                      "fees" : feeEntries.map((entry){
                        return {
                          "type" :entry["type"],
                          "amount" : entry["controller"].text,
                        };
                      }).toList()
                    });
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Fees Allotment Created Successfully")));
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Amount Cannot Be Empty")));
                  }
                },
                child: const Text("SUBMIT"),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
