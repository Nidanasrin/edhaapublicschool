import 'package:flutter/material.dart';
import '../../../../dummydata/datas.dart';

class ApaarNumber extends StatefulWidget {
  final String selectedOption;
  final String selectedClass;

  const ApaarNumber({
    super.key,
    required this.selectedOption,
    required this.selectedClass,
  });

  @override
  State<ApaarNumber> createState() => _ApaarNumberState();
}

class _ApaarNumberState extends State<ApaarNumber> {
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
              // ✅ Fixed: ListView inside Expanded to avoid layout error
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
                          horizontal: 8, vertical: 4),
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
                            hintText: "Apaar ID",
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
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.white,
                    thickness: 1,
                    height: 0,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // ✅ Fixed logic: check if at least one field is filled
                  bool hasApaarId = controllers.values.any(
                        (controller) => controller.text.trim().isNotEmpty,
                  );

                  if (!hasApaarId) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                        Text("Please enter at least one Apaar ID"),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Apaar IDs updated successfully!"),
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
                  side: const BorderSide(color: Colors.white, width: 2),
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
