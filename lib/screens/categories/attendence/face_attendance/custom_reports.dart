import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';

class CustomReports extends StatefulWidget {
  const CustomReports({super.key});

  @override
  State<CustomReports> createState() => _CustomReportsState();
}

class _CustomReportsState extends State<CustomReports> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  bool isLoading = false;
  String? userType;
  String? selectedStaff;
  String? selectedClass;
  String? selectedStudent;
  Future<void> pickFromDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        fromDateController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  Future<void> pickToDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        toDateController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  String convertTofirebase(String date) {
    final parts = date.split('/');
    return '${parts[2]} - ${parts[1]} - ${parts[0]}';
  }

  Future<void> uploadToFirebase() async {
    setState(() {
      isLoading = true;
    });
    if (fromDateController.text.isEmpty ||
        toDateController.text.isEmpty ||
        userType == null ||
        (userType == 'Staff' && selectedStaff == null) ||
        (userType == 'Students' && (selectedClass == null) ||
            selectedStudent == null)) {
      msgBox();
      setState(() {
        isLoading = false;
      });
      return;
    }
    String formattedFromDate = convertTofirebase(fromDateController.text);
    String formattedToDate = convertTofirebase(toDateController.text);
    String documentId = userType == 'Staff'
        ? selectedStaff!
        : '${selectedClass!} - ${selectedStudent!}';
    try {
      await FirebaseFirestore.instance
          .collection('attendance')
          .doc('face_attendance')
          .collection('custom_reports')
          .doc(userType)
          .collection(documentId)
      .doc('$formattedFromDate - $formattedToDate')
          .set({
        'fromDate' : formattedFromDate,
        'toDate' : formattedToDate,
        'staff' : selectedStaff,
        'class' : selectedClass,
        'student' : selectedStudent,
        'createdAt' : DateTime.now()
      });
      msgBox2();
    } catch (e) {
      print('Error : $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  void msgBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: Colors.white,
        title: Text(
          "Message",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Please fill all required fields.",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK", style: TextStyle(color: Colors.indigo.shade900)),
          ),
        ],
      ),
    );
  }

  void msgBox2() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: Colors.white,
        title: Text(
          "Message",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        content: Text(
          "No Attendance Details Available.",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK", style: TextStyle(color: Colors.indigo.shade900)),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "Select                     :",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: DropdownButtonFormField<String>(
                    value: userType,
                    isExpanded: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Select ",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    items: ["Staff", "Students"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        userType = value;
                        selectedStaff = null;
                        selectedClass = null;
                        selectedStudent = null;
                      });
                    },
                  ),
                ),
              ],
            ),

            if (userType == "Staff") ...[
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Select Staff           :",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: DropdownButtonFormField<String>(
                      value: selectedStaff,
                      isExpanded: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Select ",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      items: staffNames.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedStaff = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ] else if (userType == "Students") ...[
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Select Class          :",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: DropdownButtonFormField<String>(
                      value: selectedClass,
                      isExpanded: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Select ",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      items: list.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedClass = value;
                          selectedStudent = null;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (selectedClass != null)
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Select Student      :",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: DropdownButtonFormField<String>(
                        value: selectedStudent,
                        isExpanded: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Select ",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        items: classStudents[selectedClass]!.map((
                          String value,
                        ) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedStudent = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
            ],
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "From Date             :",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: TextField(
                    onTap: () {
                      pickFromDate();
                    },
                    controller: fromDateController,
                    readOnly: true,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.calendar_month,
                          color: Colors.blueGrey,
                        ),
                        onPressed: () => pickFromDate(),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: "Select Date",
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "To Date                  :",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: TextField(
                    onTap: () {
                      pickToDate();
                    },
                    controller: toDateController,
                    readOnly: true,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.calendar_month,
                          color: Colors.blueGrey,
                        ),
                        onPressed: () => pickToDate(),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: "Select Date",
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 60.0),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.white, width: 2),
                      ),
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (fromDateController.text.isNotEmpty &&
                          toDateController.text.isNotEmpty &&
                          userType != null) {
                        uploadToFirebase();
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> ));
                      }
                    },
                    child: Text("SUBMIT"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
