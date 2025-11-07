import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddDocuments2 extends StatefulWidget {
final String selectedStudent;
final String selectedClass;

  const AddDocuments2({super.key, required this.selectedStudent, required this.selectedClass});
  @override
  State<AddDocuments2> createState() => _AddDocuments2State();
}

class _AddDocuments2State extends State<AddDocuments2> {
  TextEditingController docNameController = TextEditingController();
  TextEditingController docNoController = TextEditingController();
  TextEditingController subByController = TextEditingController();


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
    if (docNameController.text.isEmpty || subByController.text.isEmpty ||
        docNoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Document added successfully")),
    );

    // ✅ Clear fields
    setState(() {
      docNameController.clear();
      docNoController.clear();
      subByController.clear();
      selectedFile = null;
    });
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
                  buildLabelAndField("Document Name", docNameController, "Document Name"),
                  SizedBox(height: 10,),
                  buildLabelAndField("Document No", docNoController, "Document No"),
                  SizedBox(height: 10,),
                  Row(
                      children: [
                        const Expanded(
                          flex: 3,
                          child: Text("Attach File   ", style: TextStyle(color: Colors.white, fontSize: 16)),
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
                  SizedBox(height: 10,),
                  buildLabelAndField("Submitted by", subByController, "Submitted by"),
                  SizedBox(height: 30,),
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
            hintStyle: TextStyle(color: Colors.grey),
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

