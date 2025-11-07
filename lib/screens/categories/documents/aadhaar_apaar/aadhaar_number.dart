import 'package:flutter/material.dart';
import '../../../../dummydata/datas.dart';

class AadhaarNumber extends StatefulWidget {
  final String selectedOption;
  final String selectedClass;

  const AadhaarNumber({
    super.key,
    required this.selectedOption,
    required this.selectedClass,
  });

  @override
  State<AadhaarNumber> createState() => _AadhaarNumberState();
}

class _AadhaarNumberState extends State<AadhaarNumber> {
  final Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    final students = classStudents[widget.selectedClass] ?? [];
    for (var student in students) {
      controllers[student] = TextEditingController();
    }
  }

  @override
  void dispose() {
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
      body: SafeArea(
        child: students.isEmpty
          ? const Center(
        child: Text(
          'No students found',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      )
          : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final studentName = students[index];
                    final controller = controllers.putIfAbsent(
                      studentName,
                          () => TextEditingController(),
                    );

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      title: Text(
                        studentName,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: SizedBox(
                        width: 150,
                        child: TextField(
                          controller: controller,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "Aadhaar Number",
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 10,
                            ),
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
                  const Divider(color: Colors.white, thickness: 1,height: 0,),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  bool hasAadhaar = controllers.values.any(
                        (controller) => controller.text.trim().isNotEmpty,
                  );

                  if (!hasAadhaar) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Please enter at least one Aadhaar number"),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Aadhaar numbers updated successfully!"),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: Colors.blueGrey.shade900,
                  foregroundColor: Colors.white,
                  side:
                  const BorderSide(color: Colors.white, width: 2),
                ),
                child: const Text("UPDATE"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
