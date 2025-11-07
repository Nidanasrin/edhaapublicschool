import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

import '../../../dummydata/datas.dart';

class AssignHomework extends StatefulWidget {
  const AssignHomework({super.key});

  @override
  State<AssignHomework> createState() => _AssignHomeworkState();
}

class _AssignHomeworkState extends State<AssignHomework> {

  Uint8List? _signatureImage;
  TextEditingController workController = TextEditingController();
  String? selectedClass;
  String? selectedSubject;
  bool photoSelected = false;
  File? selectedImage;

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }


  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  void msgBox(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(backgroundColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          content: Column(mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  pickImage();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.indigo.shade900,
                  side: BorderSide(color: Colors.indigo.shade900, width: 2),
                ),
                child: const Text("OPEN CAMERA"),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  _pickImageFromGallery();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.indigo.shade900,
                  side: BorderSide(color: Colors.indigo.shade900, width: 2),
                ),
                child: const Text("PICK IMAGE FROM GALLERY"),
              ),
          ],
        )
        ));
  }

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
        padding: const EdgeInsets.all(8.0),
    child:  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    rowField(
    title: "Select Class",
    hintText: "Select Class",
    value: selectedClass,
    items: list,
    onChanged: (value) {
    setState(() {
    selectedClass = value;
    });
    },
    ),
    SizedBox(height: 10),
    rowField(
    title: "Select Subject",
    hintText: "Select Subject",
    value: selectedSubject,
    items: subjects,
    onChanged: (value) {
    setState(() {
    selectedSubject = value;
    });
    },
    ),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
                flex: 4,
                child: Text("Home Work", style: TextStyle(color: Colors.white,fontSize: 16))),
            SizedBox(width: 10),
            Expanded(
              flex: 5,
              child: TextField(
              controller: workController,
              style: const TextStyle(color: Colors.black),maxLines: 2,
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
      SizedBox(height: 15),
      Row(
        children: [
          const Expanded(
            flex: 4,
            child: Text(
              "Signature                        :",
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
                  color: Colors.blueGrey.shade900,
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
      Row(
        children: [
          const Expanded(
            flex: 4,
            child: Text(
              "Attach File (Optional)                   :",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          Expanded(
            flex: 5,
            child: GestureDetector(
              onTap: () {
                msgBox();
                setState(() {
                  photoSelected = !photoSelected;
                });
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[800],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white),
                  image: photoSelected
                      ? const DecorationImage(
                    image: AssetImage("assets/sample.jpg"),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: !photoSelected
                    ? const Icon(Icons.add_a_photo, color: Colors.white)
                    : null,
              ),
                )
              ),
        ],
      ),
        SizedBox(height: 25,),
        Center(
            child: ElevatedButton(
              onPressed: () {
                if(selectedImage==null || workController.text.isEmpty || selectedClass!.isEmpty ||selectedSubject == null || signatureController.isEmpty ){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all the details")));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: const BorderSide(color: Colors.white),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("SUBMIT", style: TextStyle(color: Colors.white)),
            ),
        ),
    ])
    )
    );
  }
}
Widget rowField({
  required String title,
  required String hintText,
  String? value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return Row(
    children: [
      Expanded(
          flex: 4,
          child: Text(title, style: TextStyle(color: Colors.white, fontSize: 18))),
      SizedBox(width: 10),
      Expanded(
        flex: 5,
        child: DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
          items: items
              .map((e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e, style: TextStyle(color: Colors.black)),
          ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    ],
  );
}