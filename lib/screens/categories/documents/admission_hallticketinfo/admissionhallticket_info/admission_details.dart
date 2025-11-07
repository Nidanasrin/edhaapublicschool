import 'package:flutter/material.dart';
import '../../../../../dummydata/datas.dart';

class AdmissionDetails extends StatefulWidget {
  final String selectedOption;
  final String selectedClass;

  const AdmissionDetails({
    super.key,
    required this.selectedOption,
    required this.selectedClass,
  });

  @override
  State<AdmissionDetails> createState() => _AdmissionDetailsState();
}

class _AdmissionDetailsState extends State<AdmissionDetails> {
  final Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    // Initialize controllers for all students
    final students = classStudents[widget.selectedClass] ?? [];
    for (var student in students) {
      controllers[student] = TextEditingController();
    }
  }

  @override
  void dispose() {
    // Dispose all controllers to prevent memory leaks
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final students = classStudents[widget.selectedClass] ?? [];

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: students.isEmpty
          ? const Center(
        child: Text(
          'No students found',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      )
          : Column(
        children: [
          SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: students.length,
          itemBuilder: (context, index) {
            final studentName = students[index];
            final controller = controllers.putIfAbsent(
                studentName, () => TextEditingController());

            return ListTile(
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              title: Text(
                studentName,
                style: const TextStyle(color: Colors.white),
              ),
              trailing: SizedBox(
                width: 120,
                child: TextField(
                  controller: controller,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Admission Number",
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 10),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) =>
          const Divider(color: Colors.white, thickness: 1, height: 0),
        ),
      ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              if (controllers.isEmpty ) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter at least one Admission Number")));

              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Admission Number updated Successfully")));
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              backgroundColor: Colors.blueGrey.shade900,
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.white, width: 2),
            ),
            child: const Text("UPDATE"),
          ),
          SizedBox(height: 20,),
    ]
      )
    );
  }
}
