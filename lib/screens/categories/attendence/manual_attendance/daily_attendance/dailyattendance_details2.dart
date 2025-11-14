import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/attendence/manual_attendance/daily_attendance/dailyattendance_details3.dart';
import 'package:signature/signature.dart';

class DailyattendanceDetails2 extends StatefulWidget {
  final String className;
  final List<String> students;
  final String date;
  final Set<int> absentees;

  const DailyattendanceDetails2({
    super.key,
    required this.className,
    required this.students,
    required this.date,
    required this.absentees,
  });

  @override
  State<DailyattendanceDetails2> createState() =>
      _DailyattendanceDetails2State();
}

class _DailyattendanceDetails2State extends State<DailyattendanceDetails2> {
  SignatureController signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );
  Uint8List? savedSignature;

  void openSignatureDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        title: Text("Signature Panel", style: TextStyle(color: Colors.black)),
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: Colors.black),
            color: Colors.white,
          ),
          width: double.maxFinite,
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Signature(
              controller: signatureController,
              backgroundColor: Colors.white,
            ),
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
                  if (signatureController.isNotEmpty) {
                    final signature = await signatureController.toPngBytes();
                    if (signature != null) {
                      setState(() {
                        savedSignature = signature;
                      });
                    }
                  }
                  Navigator.pop(context);
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> submitAttendance() async {
    try {
      String? signatureUrl;
      if (savedSignature != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('attendance_signature')
            .child("${widget.className}_${widget.date}.png");

        await storageRef.putData(savedSignature!);
        signatureUrl = await storageRef.getDownloadURL();
      }

      // 2️⃣ Prepare absentee list
      Map<String, dynamic> absenteesData = {};

      for (int index in widget.absentees) {
        int roll = index + 1;
        absenteesData[roll.toString()] = widget.students[index];
      }

      // 3️⃣ Store attendance in Firestore
      await FirebaseFirestore.instance
          .collection("attendance")
          .doc('manual_attendance')
          .collection('daile_attendance')
          .doc(widget.className)
          .collection("dates")
          .doc(widget.date)
          .set({
            "className": widget.className,
            "date": widget.date,
            "totalStudents": widget.students.length,
            "absentCount": widget.absentees.length,
            "presentCount": widget.students.length - widget.absentees.length,
            "absentees": absenteesData,
            "signatureUrl": signatureUrl ?? "",
            "timestamp": FieldValue.serverTimestamp(),
          });

      // 4️⃣ Success Message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Success"),
          content: Text("Attendance submitted successfully!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DailyattendanceDetails3(
                      absentees: widget.absentees,
                      students: widget.students,
                    ),
                  ),
                );
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      print("Error submitting attendance: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.shade900,
        title: Row(
          children: [
            Text("Class : ", style: TextStyle(fontSize: 15)),
            Text(
              widget.className,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          Text("Date : ", style: TextStyle(fontSize: 16)),
          Text(
            widget.date,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
        child: widget.absentees.isEmpty
            ? Center(
                child: Text(
                  "No Absentees 🎉",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            : Column(
                children: [
                  ListTile(
                    tileColor: Colors.green.shade900,
                    textColor: Colors.white,
                    title: Text("Absentees", style: TextStyle(fontSize: 17)),
                    trailing: Text(
                      "${widget.absentees.length}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          Divider(thickness: 0.7, height: 0),
                      itemCount: widget.absentees.length,
                      itemBuilder: (context, index) {
                        // get roll number
                        int rollNo = widget.absentees.elementAt(index) + 1;
                        // get student name
                        String studentName = widget.students[rollNo - 1];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Text(
                            "$rollNo",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                          title: Text(
                            studentName,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Text(
                          "Signature",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                      Text(":", style: TextStyle(color: Colors.white)),
                      SizedBox(width: 40),
                      Expanded(
                        child: GestureDetector(
                          onTap: openSignatureDialog,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            height: 100,
                            width: 80,
                            child: savedSignature != null
                                ? Image.memory(savedSignature!)
                                : Center(child: Text("Tap to Sign")),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.transparent,
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: Text(
                            "Message",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Text(
                            "Attendance Submitted Successfully",
                            style: TextStyle(fontSize: 16),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "CANCEL",
                                style: TextStyle(color: Colors.indigo.shade900),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DailyattendanceDetails3(
                                          absentees: widget.absentees,
                                          students: widget.students,
                                        ),
                                  ),
                                );
                              },
                              child: Text(
                                "OK",
                                style: TextStyle(color: Colors.indigo.shade900),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 30.0),
                ],
              ),
      ),
    );
  }
}
