import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class OrgEditpage extends StatefulWidget {
final String docId;

  const OrgEditpage({super.key,  this.docId = 'organisation_details'});
  @override
  State<OrgEditpage> createState() => _OrgEditpageState();
}

class _OrgEditpageState extends State<OrgEditpage> {
  final formkey = GlobalKey<FormState>();
  File? selectedImage;
  bool isLoading = false;

  final _nameController = TextEditingController();
  final _studentsController = TextEditingController();
  final _personController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchOrganisationData();
  }

  Future<void> fetchOrganisationData() async {
    setState(() => isLoading = true);
    try {
      final doc = await FirebaseFirestore.instance
          .collection('organisation_details')
          .doc(widget.docId)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        _nameController.text = data["Organisation_name"] ?? '';
        _studentsController.text = data["Approx_students"]?.toString() ?? '';
        _personController.text = data["Authorized_person"] ?? '';
        _contactController.text = data["contact_no"]?.toString() ?? '';
        _emailController.text = data["email"] ?? '';
        _addressController.text = data["address"] ?? '';
      }
    } catch (e) {
      print("Error fetching organisation: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

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

  Future<String?> uploadImageToFirebase() async {
    if (selectedImage == null) return null;
    try {
      final ref = FirebaseStorage.instance.ref().child(
        'organisation_photos/${DateTime.now().microsecondsSinceEpoch}.jpg',
      );
      await ref.putFile(selectedImage!);
      return await ref.getDownloadURL();
    } catch (e) {
      print("Image upload error: $e");
      return null;
    }
  }

  Future<void> updateOrganisationDetails() async {
    setState(() => isLoading = true);
    try {
      String? photoUrl = await uploadImageToFirebase();
      final docRef = FirebaseFirestore.instance
          .collection('organisation_details')
          .doc(widget.docId);
      final updateDate = {
        "Organisation_name": _nameController.text,
        "Approx_students": int.tryParse(_studentsController.text) ?? 0,
        "Authorized_person": _personController.text,
        "contact_no": int.tryParse(_contactController.text) ?? 0,
        "email": _emailController.text,
        "address": _addressController.text,
      };
      if (photoUrl != null) {
        updateDate['photoUrl'] = photoUrl;
      }
      await docRef.update(updateDate);
      Fluttertoast.showToast(
        msg: 'Organisation Details Updated',
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.green,
      );
      Navigator.pop(context);
    } catch (e) {
      print("Error updating organisation: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.blueGrey.shade900, // Dark background like details page
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Edit Organisation",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body:  isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              buildTextField("Organisation Name", _nameController),
              buildTextField(
                "Approx. Students",
                _studentsController,
                keyboardType: TextInputType.number,
              ),
              buildTextField("Authorized Person", _personController),
              buildTextField(
                "Contact No",
                _contactController,
                keyboardType: TextInputType.phone,
              ),
              buildTextField(
                "Email",
                _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              buildTextField("Address", _addressController, maxLines: 3),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Photo",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      flex: 5,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: selectedImage == null
                              ? Center(
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    selectedImage!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      updateOrganisationDetails();
                    }
                  },
                  child: const Text("UPDATE", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              "$label  ",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          Expanded(
            flex: 5,
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              maxLines: maxLines,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white12, // light background inside textfield
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white70),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter $label";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
