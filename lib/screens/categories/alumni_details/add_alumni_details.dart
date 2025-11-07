import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raynottschool/dummydata/datas.dart';

class AddAlumniDetails extends StatefulWidget {
  const AddAlumniDetails({super.key});

  @override
  State<AddAlumniDetails> createState() => _AddAlumniDetailsState();
}

class _AddAlumniDetailsState extends State<AddAlumniDetails> {
  bool photoSelected = false;

  TextEditingController studentNameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController contactNo = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController designController = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController packageController = TextEditingController();
  TextEditingController studiedController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  String? selectedValue;

  void msgbox() {
    showDialog(context: context, builder: (context) =>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
          ),
          title: Text("Message"),
          content: Text(
              "Alumni Details Saved Successfully"),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context);
            },
                child: Text(
                  "Ok", style: TextStyle(color: Colors.indigo.shade900),))
          ],
        ));
  }

  File? selectedImage;

  Future<void> _pickImage() async {
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

  void imagebox(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
          backgroundColor: Colors.white,
          content: Column(mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,

                      side: BorderSide(color: Colors.indigo.shade900,width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  onPressed: pickImage, child: Text("OPEN CAMERA",style: TextStyle(color: Colors.indigo.shade900),)),
              SizedBox(height: 10,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.indigo.shade900,width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  onPressed: _pickImage, child: Text("PICK IMAGE FROM GALLERY",style: TextStyle(color: Colors.indigo.shade900),))
            ],
          ),
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.blueGrey.shade900,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRow("Student Name", "Student Name", studentNameController),
              SizedBox(height: 15,),
              buildRow("Father Name", "Father Name", fatherNameController),
              SizedBox(height: 15,),
              buildRow("Contact No", "Contact No", contactNo),
              SizedBox(height: 15,),
              buildRow("Address", "Address", addressController),
              SizedBox(height: 15,),
              buildRow("Highest Qualification", "Highest Qualification", qualificationController),
              SizedBox(height: 15,),
              buildRow("Current Designation", "Current Designation", designController),
              SizedBox(height: 15,),
              buildRow("Company Name", "Company Name", companyName),
              SizedBox(height: 15,),
              buildRow("Current Package", "Current Package", packageController),
              SizedBox(height: 15,),
              buildRow("Classes Studied", "Classes Studied", studiedController),
              SizedBox(height: 15,),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text("Academic Year", style: TextStyle(color: Colors.white,fontSize: 16)),
                DropdownButtonFormField<String>(
                    value: selectedValue,
                    isExpanded: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Academic Year",
                      contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    items: year.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                    onChanged: (value){
                      selectedValue = value;
                    },
                  ),
              ],
            ),
              SizedBox(height: 15,),
              buildRow("Current Country", "Current Country", countryController),
              SizedBox(height: 15,),
              buildRow("Notes", "Notes", notesController),
              SizedBox(height: 15,),
              Row(
                children: [
              Text("Photo", style: TextStyle(color: Colors.white,fontSize: 16)),
               SizedBox(width: 75),
              GestureDetector(
                  onTap: () {
                    imagebox();
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
              ),
              ]
              ),
              SizedBox(height: 20,),
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
                    if(studentNameController.text.isNotEmpty &&
                        fatherNameController.text.isNotEmpty &&
                        contactNo.text.isNotEmpty &&
                        addressController.text.isNotEmpty &&
                        selectedValue != null &&
                        selectedImage != null) {

                      // Create a simple data map to send back
                      final newAlumni = {
                        'studentName': studentNameController.text,
                        'fatherName': fatherNameController.text,
                        'company': companyName.text,
                        'image': selectedImage!.path,
                      };
                      Navigator.pop(context, newAlumni);
                      msgbox();
                    } else {
                      Fluttertoast.showToast(msg: "Please give the details",gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_SHORT);
                    }
                  },
                  child: const Text("SUBMIT"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
Widget buildRow(String title,String hintText,TextEditingController controller){
  return  Column(crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      SizedBox(height: 3,),
      TextField(
          controller: controller,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,hintText: hintText,hintStyle: TextStyle(color: Colors.grey,fontSize: 16),
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5)),
          ),
        ),
    ],
  );
}