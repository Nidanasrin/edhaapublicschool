import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class StaffRegistrationForm extends StatefulWidget {
  const StaffRegistrationForm({super.key});

  @override
  State<StaffRegistrationForm> createState() => _StaffRegistrationFormState();
}

class _StaffRegistrationFormState extends State<StaffRegistrationForm> {
  final TextEditingController staffNameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String? selectedRelation = "S/O";
  String? selectedGender = "Male";
  File? selectedImage;

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

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A), // Dark background
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Initial",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 5,
                  child: TextField(
                    controller: staffNameController,
                    decoration: const InputDecoration(
                      hintText: "Staff Name",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // S/O dropdown and name
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    value: selectedRelation,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                    items: ["S/O", "D/O", "W/O"]
                        .map((relation) => DropdownMenuItem(
                      value: relation,
                      child: Text(relation),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRelation = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 5,
                  child: TextField(
                    controller: fatherNameController,
                    decoration: const InputDecoration(
                      hintText: "Name",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Gender
            const Text("Gender", style: TextStyle(color: Colors.white)),
            Row(
              children: [
                Radio<String>(
                  value: "Male",
                  groupValue: selectedGender,
                  activeColor: Colors.pinkAccent,
                  onChanged: (value) {
                    setState(() => selectedGender = value);
                  },
                ),
                const Text("Male", style: TextStyle(color: Colors.white)),
                Radio<String>(
                  value: "Female",
                  groupValue: selectedGender,
                  activeColor: Colors.pinkAccent,
                  onChanged: (value) {
                    setState(() => selectedGender = value);
                  },
                ),
                const Text("Female", style: TextStyle(color: Colors.white)),
              ],
            ),

            const SizedBox(height: 5),
            // Designation
            TextField(
              controller: designationController,
              decoration: const InputDecoration(
                hintText: "Designation",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
            const SizedBox(height: 10),

            // Date of Birth
            TextField(
              controller: dobController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "dd / mm / yyyy",
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.purple),
                  onPressed: pickDate,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
            const SizedBox(height: 10),

            // Mobile No
            TextField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "Mobile No",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
            const SizedBox(height: 10),

            // Email
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Email (optional)",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
            const SizedBox(height: 10),

            // Address
            TextField(
              controller: addressController,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: "Address",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              ),
            ),
            const SizedBox(height: 15),

            // Photo picker
            Row(
              children: [
                const Text("Photo", style: TextStyle(color: Colors.white)),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: pickImage,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      image: selectedImage != null
                          ? DecorationImage(
                        image: FileImage(selectedImage!),
                        fit: BoxFit.cover,
                      )
                          : null,
                    ),
                    child: selectedImage == null
                        ? const Icon(Icons.person, size: 60, color: Colors.grey)
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if(staffNameController.text.isNotEmpty &&
                      fatherNameController.text.isNotEmpty &&
                      designationController.text.isNotEmpty &&
                      dobController.text.isNotEmpty &&
                      mobileController.text.isNotEmpty &&
                      addressController.text.isNotEmpty &&
                      selectedImage != null &&
                      selectedGender != null &&
                      selectedRelation != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Staff details submitted!")),
                    );
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill all the details")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(color: Colors.white, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
                child: const Text("SUBMIT",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
