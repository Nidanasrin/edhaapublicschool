import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'package:signature/signature.dart';

class ApplyFeesconcession extends StatefulWidget {
  const ApplyFeesconcession({super.key});

  @override
  State<ApplyFeesconcession> createState() => _ApplyFeesconcessionState();
}

class _ApplyFeesconcessionState extends State<ApplyFeesconcession> {
  String? selectedType;
  String? selectedYear;
  String? selectedClass;
  String? selectedStudent;
  TextEditingController amountController = TextEditingController();
  TextEditingController wordsController = TextEditingController();
  TextEditingController approvedByController = TextEditingController();

  Uint8List? _signatureImage;
  SignatureController signatureController = SignatureController(
      exportBackgroundColor: Colors.white,
      penColor: Colors.black,
      penStrokeWidth: 2
  );


  @override
  void dispose() {
    signatureController.dispose();
    super.dispose();
  }

  void openSignatureDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          "Signature Panel",
          style: TextStyle(color: Colors.black),
        ),
        content: SizedBox(
          width: double.maxFinite,
          height: 200, // Make sure the height is enough
          child: Signature(
            controller: signatureController,
            backgroundColor: Colors.grey.shade200, // Light gray to see strokes
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 2, color: Colors.black),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 2, color: Colors.black),
                  ),
                ),
                onPressed: () {
                  signatureController.clear();
                },
                child: const Text(
                  'Clear',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 2, color: Colors.black),
                  ),
                ),
                onPressed: () async {
                  final image = await signatureController.toPngBytes();
                  if (image != null && mounted) {
                    setState(() {
                      _signatureImage = image;
                    });
                  }
                  Navigator.pop(context);
                },
                child: const Text(
                  'Done',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            buildRowDropDown(
              "Select FeeType                           :","Select Type",
              selectedType,
              feeTypes,
              (value) {
                setState(() => selectedType = value);
              },
            ),
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
            SizedBox(height: 15),
            buildRowDropDown(
              "Select Student                           :","Select Student",
              selectedStudent,
              selectedClass != null ? (classStudents[selectedClass] ??[]) : [],
              (value) {
                setState(() => selectedStudent = value);
              },
            ),
            SizedBox(height: 25),
            rowField(
              "Amount                                :",
              amountController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 15),
            rowField("Amount in Words                :", wordsController),
            const SizedBox(height: 15),
            rowField(
              "Approved By                        :",
              approvedByController,
            ),
            SizedBox(height: 15),
            Row(
              children: [
                const Expanded(
                  flex: 5,
                  child: Text(
                    "Parent Signature                 :",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: GestureDetector(
                    onTap: openSignatureDialog,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: _signatureImage == null
                          ? Center(
                              child: Text(
                                "Tap to Sign",
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : Image.memory(_signatureImage!, fit: BoxFit.contain),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                if (selectedType == null ||
                    selectedYear == null ||
                    selectedClass == null ||
                    selectedStudent == null ||
                    amountController.text.trim().isEmpty ||
                    wordsController.text.trim().isEmpty ||
                    approvedByController.text.trim().isEmpty ||
                    _signatureImage == null) {
                  _showMsg(context, "Please fill all fields!");
                } else {
                  _showMsg(context, "Concession Applied Successfully!");
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

  void _showMsg(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
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

  Widget rowField(
    String title,
    TextEditingController controller, {
    TextInputType? keyboardType,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Expanded(
          flex: 5,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
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
    );
  }
}
