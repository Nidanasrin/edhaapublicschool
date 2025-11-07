import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class GreetingForm extends StatefulWidget {
  const GreetingForm({super.key});

  @override
  State<GreetingForm> createState() => _GreetingFormState();
}

class _GreetingFormState extends State<GreetingForm> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;
  // For simplicity, photo will be just a placeholder
  bool photoSelected = false;

  Future<void> _pickDate(TextEditingController controller, bool isFrom) async {
    DateTime initialDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
        if (isFrom) {
          fromDate = pickedDate;
        } else {
          toDate = pickedDate;
        }
      });
    }
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
  void dispose() {
    fromDateController.dispose();
    toDateController.dispose();
    titleController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueGrey[900],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("From Date", style: TextStyle(color: Colors.white)),
            const SizedBox(height: 5),
            TextField(
              controller: fromDateController,
              readOnly: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blueGrey[800],
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.white),
                  onPressed: () => _pickDate(fromDateController, true),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: 'dd/MM/yyyy',
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            const Text("To Date", style: TextStyle(color: Colors.white)),
            const SizedBox(height: 5),
            TextField(
              controller: toDateController,
              readOnly: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blueGrey[800],
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.white),
                  onPressed: () => _pickDate(toDateController, false),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: 'dd/MM/yyyy',
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Title", style: TextStyle(color: Colors.white)),
            const SizedBox(height: 5),
            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blueGrey[800],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: "Ex: Happy Diwali",
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Message Greeting", style: TextStyle(color: Colors.white)),
            const SizedBox(height: 5),
            TextField(
              controller: messageController,
              maxLines: 5,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blueGrey[800],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: "Message Greeting",
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Photo", style: TextStyle(color: Colors.white)),
            const SizedBox(height: 5),
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
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle submit
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
          ],
        ),
      ),
    );
  }
}
