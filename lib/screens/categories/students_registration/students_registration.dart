import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:raynottschool/dummydata/datas.dart';

class StudentsRegistration extends StatefulWidget {
  const StudentsRegistration({super.key});

  @override
  State<StudentsRegistration> createState() => _StudentsRegistrationState();
}

class _StudentsRegistrationState extends State<StudentsRegistration> {
  final TextEditingController nameInitialController = TextEditingController();
  final TextEditingController studentNameController = TextEditingController();
  final TextEditingController fatherNameController =
  TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController rollnoController = TextEditingController();
  final TextEditingController mobileController =
  TextEditingController();
  final TextEditingController addressController = TextEditingController();

String? selectedvalue;

  bool photoSelected = false;
  File? selectedImage;

  Future<void> pickImage() async {
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


  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(1995),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        dobController.text = DateFormat('dd / MM / yyyy').format(pickedDate);
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
                  onPressed: pickImage, child: Text("PICK IMAGE FROM GALLERY",style: TextStyle(color: Colors.indigo.shade900),))
            ],
          ),
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: buildField("Initial", nameInitialController)
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 3,
                child: buildField("Student Name", studentNameController)
              ),
            ],
          ),SizedBox(height: 10,),
          buildField("Father name", fatherNameController),
          SizedBox(height: 10,),
          DropdownButtonFormField<String>(
            value: selectedvalue,
            decoration: const InputDecoration(
              filled: true,hintText: "Select Class",
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
            ),
            items: list
                .map((relation) => DropdownMenuItem(
              value: relation,
              child: Text(relation),
            ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedvalue = value;
              });
            },
          ),SizedBox(height: 10,),
          buildField("Roll Number", rollnoController),
          SizedBox(height: 10,),
          TextField(
            onTap: (){
              pickDate();
            },
            controller: dobController,
            readOnly: true,
            decoration: InputDecoration(
              hintText: "dd / mm / yyyy",
              filled: true,
              hintStyle: TextStyle(color: Colors.grey),
              fillColor: Colors.white,
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today, color: Colors.purple),
                onPressed: pickDate,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
          SizedBox(height: 10,),
          buildField("Mobile Number", mobileController),
          SizedBox(height: 10,),
          buildField("Address", addressController,maxLines: 3),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Text("Photo", style: TextStyle(color: Colors.white)),
           SizedBox(width: 15),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
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
          ),
          ]
          ),
          SizedBox(height: 20),

          // Submit Button
          Center(
            child: ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey.shade900,
                side: const BorderSide(color: Colors.white, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              child: const Text("PREVIEW",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ]),
      ),
    );
  }
}

Widget buildField(String hintText, TextEditingController controller,{int maxLines = 1}) {
  return TextField(
    decoration: InputDecoration(
      fillColor: Colors.white,
      filled: true,
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
    ),
    controller: controller,
  );
}
