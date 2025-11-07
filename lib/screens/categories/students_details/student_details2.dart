import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'package:raynottschool/screens/categories/students_details/students_details3.dart';

class StudentDetails2 extends StatefulWidget {
  final String selectedClass;

  const StudentDetails2({super.key, required this.selectedClass});

  @override
  State<StudentDetails2> createState() => _StudentDetails2State();
}

class _StudentDetails2State extends State<StudentDetails2> {
  late List<String> students;
  late List<String> filteredStudents;
  late List<bool> isSwitched;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    students = classStudents[widget.selectedClass] ?? [];
    filteredStudents = List.from(students);
    isSwitched = List.generate(students.length, (_) => false);
  }

  void filterStudents(String query) {
    setState(() {
      filteredStudents = students
          .where((name) => name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  void showStatusDialog(String title, String message, Color color) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.white,
        title:
            Text(title, style: TextStyle(color: color,fontSize: 16)),
        content: Text(
          message,
          style: const TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
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
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row for color info
            Row(
              children: const [
                Icon(Icons.circle, color: Colors.red, size: 15),
                SizedBox(width: 6),
                Text(
                  "Color indicates change the photo",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 15),

            TextField(
              controller: searchController,
              onChanged: filterStudents,
              decoration: InputDecoration(
                hintText: "Search student...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 15),

            Expanded(
              child: ListView.separated(
                itemCount: filteredStudents.length,
                separatorBuilder: (_, __) => const Divider(
                  color: Colors.white24,
                  thickness: 0.5,
                ),
                itemBuilder: (context, index) {
                  final name = filteredStudents[index];
                  final originalIndex = students.indexOf(name);

                  return ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentsDetails3(studentName: name, selectedClass: widget.selectedClass)));
                    },
                    title: Text(
                      name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: Switch(
                      value: isSwitched[originalIndex],
                      onChanged: (value) {
                        setState(() {
                          isSwitched[originalIndex] = value;
                        });
                        if (value) {
                          showStatusDialog(
                            "Student Blocked",
                            "$name has been blocked successfully.",
                            Colors.red,
                          );
                        } else {
                          showStatusDialog(
                            "Student Activated",
                            "$name has been activated successfully.",
                            Colors.green,
                          );
                        }

                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
