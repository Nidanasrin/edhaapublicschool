import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Floating extends StatefulWidget {
  const Floating({super.key});

  @override
  State<Floating> createState() => _FloatingState();
}

class _FloatingState extends State<Floating> {
  final _titleController = TextEditingController();
  final _msgController = TextEditingController();
  File? selectedImage;
  final formkey = GlobalKey<FormState>();
  Map<String, dynamic>? momentsData;
  bool isLoading = true;

  Future<void> fetchMomentsData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('app_sms')
          .doc('moments')
          .get();
      if (doc.exists) {
        setState(() {
          momentsData = doc.data() as Map<String, dynamic>;
          _titleController.text = momentsData!['title'] ?? '';
          _msgController.text = momentsData!['message'] ?? '';
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMomentsData();
  }

  Future<String?> uploadImageToFirebase() async {
    if (selectedImage == null) return null;
    final ref = FirebaseStorage.instance.ref().child(
      'photos/${DateTime.now().microsecondsSinceEpoch}.jpg',
    );
    await ref.putFile(selectedImage!);
    String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
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

  Future<void> _pickImage2() async {
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

  void camerabox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.indigo.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 2, color: Colors.indigo.shade900),
                ),
              ),
              onPressed: () {
                _pickImage2();
              },
              child: Text("OPEN CAMERA"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.indigo.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 2, color: Colors.indigo.shade900),
                ),
              ),
              onPressed: () {
                _pickImage();
              },
              child: Text("PICK IMAGE FROM GALLERY"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateMoments() async {
    try {
      String? imageUrl;
      if (selectedImage != null) {
        imageUrl = await uploadImageToFirebase();
      }
      await FirebaseFirestore.instance
          .collection('app_sms')
          .doc('moments')
          .update({
            'title': _titleController.text,
            'message': _msgController.text,
        if(imageUrl != null) 'photo' : imageUrl,
          });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Updated Successfully')));
      fetchMomentsData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900, // better contrast
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : momentsData == null
          ? Center(
              child: Text(
                "No data found",
                style: TextStyle(color: Colors.white),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    SizedBox(height: 30.0),
                    buildTextField("Title", _titleController),
                    buildTextField(
                      "Message",
                      _msgController,
                      maxLines: 3,
                    ),

                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 2,
                            child: Text(
                              "Photo :",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 5,
                            child: GestureDetector(
                              onTap: camerabox,
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: selectedImage != null
                                    ? ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  child: Image.file(
                                    selectedImage!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                )
                                    : momentsData!['photo'] != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          momentsData!['photo']!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      )
                                    : Center(
                                        child: Icon(
                                          Icons.add_a_photo,
                                          color: Colors.white,
                                          size: 40,
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
updateMoments();                          }
                        },
                        child: const Text(
                          "SUBMIT",
                          style: TextStyle(fontSize: 16),
                        ),
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
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$label :",
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          Expanded(
            flex: 7,
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              maxLines: maxLines,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white12,
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
