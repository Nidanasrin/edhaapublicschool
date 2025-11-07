import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class AddRemarks2 extends StatefulWidget {
  final String selectedStudent;
  final String selectedClass;

  const AddRemarks2({super.key, required this.selectedStudent, required this.selectedClass});

  @override
  State<AddRemarks2> createState() => _AddRemarks2State();
}

class _AddRemarks2State extends State<AddRemarks2> {
  TextEditingController addRemarkController = TextEditingController();
  TextEditingController reviewByController = TextEditingController();
  Uint8List? _signatureImage;
  SignatureController signatureController = SignatureController(
      exportBackgroundColor: Colors.white,
      penColor: Colors.black,
      penStrokeWidth: 2
  );
  File? selectedFile;

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  void saveRemark() {
    if (addRemarkController.text.isEmpty ||
        reviewByController.text.isEmpty ||
        _signatureImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields and add a signature")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Remarks added successfully")),
    );

    // ✅ Clear fields
    setState(() {
      addRemarkController.clear();
      reviewByController.clear();
      _signatureImage = null;
      selectedFile = null;
    });
  }

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
                child: Text("Cancel",style: TextStyle(fontWeight: FontWeight.bold),),
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
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
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
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
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
            padding: const EdgeInsets.all(10.0),
            child: Column(
                children: [
                  SizedBox(height: 30,),
                  buildLabelValueRow("Student Name", widget.selectedStudent),
                  SizedBox(height: 10,),
                  buildLabelValueRow("Class Name", widget.selectedClass),
                  SizedBox(height: 10,),
                  buildLabelAndField("Add Remarks", addRemarkController, "Description",maxLines: 3),
                  SizedBox(height: 10,),
                  buildLabelAndField("Reviewed by", reviewByController, "Reviewed by"),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Text(
                          "Signature",
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
                  SizedBox(height: 15),

                  // 📎 File picker section
                  Row(
                      children: [
                        const Expanded(
                          flex: 3,
                          child: Text("Attach File", style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            onTap: pickFile,
                            child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: selectedFile == null
                                    ? Center(
                                  child: Text(
                                    "Tap to Sign",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )
                                    : Image.file(selectedFile!)
                            ),
                          ),
                        ),
                      ]),
                  SizedBox(height: 30,),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(color: Colors.white, width: 2),
                        ),
                        backgroundColor: Colors.blueGrey.shade900,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        saveRemark();
                      },
                      child: const Text("SUBMIT"),
                    ),
                  )

                ])
        )
    );
  }
}
Widget buildLabelAndField(String label, TextEditingController controller,String hintText,
    {int maxLines = 1}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 2,
        child: Text("$label", style: const TextStyle(color: Colors.white,fontSize: 16)),
      ),
      Expanded(
        flex: 3,
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            fillColor: Colors.white,filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildLabelValueRow(String label, String value) {
  return Row(
    children: [
      Expanded(flex: 2,
          child: Text(label, style: const TextStyle(color: Colors.white,fontSize: 16))),
      const SizedBox(width: 70),
      Expanded(flex: 5,
        child: Text(
          ":  $value",
          style: const TextStyle(
            color: Colors.white,fontSize: 16,
          ),
        ),
      ),
    ],
  );

}
