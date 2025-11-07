import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raynottschool/screens/categories/organisation/org_editpage.dart';

class OrganisationDetails1 extends StatefulWidget {
  const OrganisationDetails1({super.key});

  @override
  State<OrganisationDetails1> createState() => _OrganisationDetails1State();
}

class _OrganisationDetails1State extends State<OrganisationDetails1> {
  Map<String, dynamic>? orgData;
 bool isLoading = true;
  File? selectedImage;
  Future<void> fetchOrganisationData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('organisation_details')
          .doc('organisation_details')
          .get();
      if (doc.exists) {
        setState(() {
          orgData = doc.data() as Map<String,dynamic>;
          isLoading = false;
        });
      }else {
        setState(() {
          isLoading = false;
        });
        print("Document not found");
      }
      }catch (e) {
      print("Error fetching data: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchOrganisationData();
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
      await uploadImageToFirebase();
    }
  }

  Future<void> uploadImageToFirebase() async {
    if (selectedImage == null) return;
    final ref = FirebaseStorage.instance.ref().child(
      'organisation_photos/${DateTime.now().microsecondsSinceEpoch}.jpg',
    );
    await ref.putFile(selectedImage!);
    String downloadUrl = await ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('organisation_details')
        .doc('organisation_details')
        .update({'photoUrl': downloadUrl});
    await fetchOrganisationData();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Photo Uploaded Successfully')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : orgData == null
          ? Center(child: Text("No data found", style: TextStyle(color: Colors.white)))
          : SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16.0, bottom: 8.0, top: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRow("Organisation Name", orgData!["Organisation_name"] ?? ""),
            buildRow("Approx. Students", orgData!["Approx_students"].toString()),
            buildRow("Registered Date", orgData!["Registered_date"] ?? ""),
            buildRow("Renewal Date", orgData!["Renewal_date"] ?? ""),
            buildRow("Expiry Date", orgData!["Expiry_date"] ?? ""),
            buildRow("Authorized Person", orgData!["Authorized_person"] ?? ""),
            buildRow("Contact No", orgData!["contact_no"].toString()),
            buildRow("Email", orgData!["email"] ?? ""),
            buildRow("Address", orgData!["address"] ?? ""),

            // buildRow("Photo", "_pickImage()"),
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
                        child:  orgData!["photoUrl"] != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            orgData!["photoUrl"],
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
                          )
                          ),
                        )
                      ),
                  )
              ]
                  )
            ),

            SizedBox(height: 10.0),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 2, color: Colors.white),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrgEditpage(docId: 'organisation_details',))
                  ).then((_) {
                    fetchOrganisationData();
                  });
                },
                child: Text("Edit", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildRow(String label, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            ":  $text",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
