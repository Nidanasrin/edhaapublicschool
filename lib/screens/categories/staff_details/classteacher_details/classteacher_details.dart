import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'package:raynottschool/screens/categories/staff_details/classteacher_details/add_classteacher.dart';

class ClassteacherDetails extends StatefulWidget {
  const ClassteacherDetails({super.key});

  @override
  State<ClassteacherDetails> createState() => _ClassteacherDetailsState();
}

class _ClassteacherDetailsState extends State<ClassteacherDetails> {
  Map<String, String> classTeacherMap = {};
  @override
  void initState() {
    super.initState();
    // Copy data from dummydata to allow editing
    classTeacherMap = {
      "GRADE-1": "Alice",
      "GRADE-2": "Bob",
      "GRADE-3": "Arya",
      "GRADE-4": "Jennifer",
      "GRADE-5": "Manya",
      "GRADE-6": "Ananya",
      "GRADE-7": "Beena",
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 35),
          Expanded(
            child: ListView.separated(
              itemCount: list.length,
              separatorBuilder: (context, index) =>
              const Divider(thickness: 1, height: 0, color: Colors.white24),
              itemBuilder: (context, index) {
                final className = list[index];
                final teacher = classTeacherMap[className] ?? "";

                return ListTile(
                  title: Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: Text(className,
                              style: const TextStyle(color: Colors.white))),
                      Expanded(
                          flex: 5,
                          child: Text(teacher,
                              style: const TextStyle(color: Colors.white))),
                    ],
                  ),
                );
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddClassteacher(),
                    ),
                  );

                  // If user submitted data
                  if (result != null && result is Map<String, String>) {
                    setState(() {
                      classTeacherMap.addAll(result);
                    });
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
                child: const Text("ADD CLASS TEACHER"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
