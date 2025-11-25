import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Daywise extends StatefulWidget {
  const Daywise({super.key});

  @override
  State<Daywise> createState() => _DaywiseState();
}

class _DaywiseState extends State<Daywise> {
  TextEditingController dateController = TextEditingController();

  String? selectedValue;
  Future<void> pickDate(
    TextEditingController controller,
    bool isFromDate,
  ) async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickDate != null) {
      String formattedDate =
          "${pickDate.day}/${pickDate.month}/${pickDate.year}";
      controller.text = formattedDate;
    }
  }

  @override
  void initState() {
    super.initState();
    selectedValue = "Staff";
  }

  String convertToFirebase(String date) {
    final parts = date.split('/');
    return '${parts[2]}-${parts[1]}-${parts[0]}';
  }

  Future<Map<String, dynamic>?> fetchData() async {
    if (dateController.text.isEmpty || selectedValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select date and category')),
      );
      return null;
    }
    String formattedDate = convertToFirebase(dateController.text);
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('attendance')
          .doc('face_attendance')
          .collection('daywise_reports')
          .doc(formattedDate)
          .collection(selectedValue!.toLowerCase())
          .doc('summary')
          .get();
      if (!snapshot.exists) {
        msgBox('No Data Available');
        return null;
      }
      return snapshot.data() as Map<String, dynamic>;
    } catch (e) {
      print('Error : $e');
      msgBox("Error fetching data");
      return null;
    }
  }

  void msgBox(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: Colors.white,
        title: Text(
          "Message",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        content: Text(message, style: TextStyle(fontSize: 16)),
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

  void consolidateBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.blue.shade900,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "From Date    :",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: TextField(
                    onTap: () {
                      pickDate(dateController, true);
                    },
                    controller: dateController,
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
                        onPressed: () => pickDate(dateController, true),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: "dd/MM/yyyy",
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.white, width: 2),
                  ),
                  backgroundColor: Colors.blue.shade900,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  // if (dateController.text.isEmpty) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(content: Text("Please Select Date")),
                  //   );
                  //   return;
                  // }
                  // Navigator.pop(context);
                  var data = await fetchData();
                  if (data != null) {
                    print('Fetched Consolidated Data : $data');
                  }
                },
                child: Text("SUBMIT"),
              ),
            ),
          ],
        ),
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
                    "Select                    :",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: DropdownButtonFormField<String>(
                    value: selectedValue,
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
                        selectedValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "Select Date           :",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: TextField(
                    onTap: () {
                      pickDate(dateController, true);
                    },
                    controller: dateController,
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
                        onPressed: () => pickDate(dateController, true),
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
                    onPressed: () async {
                      var data = await fetchData();
                      if (data != null) {
                        print(
                          'Fetched Data : $data',
                        ); // Navigator.push(context, MaterialPageRoute(builder: (context)=> ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please Select Date.")),
                        );
                      }
                    },
                    child: Text("SUBMIT"),
                  ),
                  SizedBox(height: 15),
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
                      if (selectedValue != null &&
                          dateController.text.isNotEmpty) {
                        consolidateBox();
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please Select Date.")),
                        );
                      }
                    },
                    child: Text("CONSOLIDATE REPORT"),
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
