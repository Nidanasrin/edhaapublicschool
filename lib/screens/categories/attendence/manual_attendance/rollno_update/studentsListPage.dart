import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Studentslistpage extends StatefulWidget {
  final String className;
  final List<String> students;

  const Studentslistpage({
    super.key,
    required this.className,
    required this.students,
  });

  @override
  State<Studentslistpage> createState() => _StudentslistpageState();
}

class _StudentslistpageState extends State<Studentslistpage> {
  late List<TextEditingController> controller;
  bool isUploading = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    controller = List.generate(
      widget.students.length,
      (index) => TextEditingController(text: "${index + 1}"),
    );
    loadExistingRollNumbers();
  }

  @override
  void dispose() {
    for (var c in controller) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> loadExistingRollNumbers() async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('attendance')
          .doc('manual_attendance')
          .collection('class_roll_numbers')
          .doc(widget.className);
      final snapshot = await docRef.get();
      if (snapshot.exists && snapshot.data() != null) {
        final data = snapshot.data()!;
        final Map<String, dynamic> studentData = Map<String, dynamic>.from(
          data['students'] ?? {},
        );
        for (int i = 0; i < widget.students.length; i++) {
          final studentName = widget.students[i];
          if (studentData.containsKey(studentName)) {
            controller[i].text = studentData[studentName].toString();
          }
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Errpor loading existing roll numbers : $e',
        gravity: ToastGravity.TOP,
      );
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> uploadToFirebase() async {
    setState(() => isUploading = true);
    try {
      final classRef = FirebaseFirestore.instance
          .collection('attendance')
          .doc('manual_attendance')
          .collection('class_roll_numbers')
          .doc(widget.className);
      Map<String, dynamic> studentData = {};
      for (int i = 0; i < widget.students.length; i++) {
        studentData[widget.students[i]] = controller[i].text.trim();
      }
      await classRef.set({
        'students': studentData,
        'updated_at': FieldValue.serverTimestamp(),
      },SetOptions(merge: true));
      Fluttertoast.showToast(
        msg: "Roll numbers updated successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
      );
      Navigator.pop(context);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: $e",
        gravity: ToastGravity.TOP,
        toastLength: Toast.LENGTH_SHORT,
      );
    } finally {
      setState(() => isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body:isLoading
          ? const Center(
        child: CircularProgressIndicator(color: Colors.white),
      )
          : Column(
        children: [
          widget.students.isEmpty
              ? Center(child: Text("No Students Found"))
              : Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final stdnt = widget.students[index];
                      return ListTile(
                        title: Text(
                          stdnt,
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: SizedBox(
                          width: 100,
                          height: 40,
                          child: TextField(
                            controller: controller[index],
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      thickness: 0.4,
                      indent: 0,
                      endIndent: 0,
                      height: 0,
                    ),
                    itemCount: widget.students.length,
                  ),
                ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: isUploading ? null : uploadToFirebase,
              child: isUploading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("SUBMIT"),
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
