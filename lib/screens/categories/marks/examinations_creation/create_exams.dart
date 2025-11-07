import 'package:flutter/material.dart';

class CreateExams extends StatefulWidget {
  const CreateExams({super.key});

  @override
  State<CreateExams> createState() => _CreateExamsState();
}

class _CreateExamsState extends State<CreateExams> {
  List<TextEditingController> controllers = [];

  void addField() {
    setState(() {
      controllers.add(TextEditingController());
    });
  }

  void submit() {
    List<String> exams = controllers
        .map((c) => c.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    Navigator.pop(context, exams); // return list to previous screen
  }

  @override
  void initState() {
    super.initState();
    addField(); // add first field by default
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1A2B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E1A2B),
        title: const Text("ENTER EXAM NAME",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: controllers[index],
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Enter Exam Name",
                        hintStyle: const TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.blue, width: 2),
                        ),
                        suffixIcon: index > 0
                            ? IconButton(
                          icon: const Icon(Icons.remove_circle,
                              color: Colors.red),
                          onPressed: () {
                            setState(() {
                              controllers.removeAt(index);
                            });
                          },
                        )
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: addField,
              child: Row(
                children: const [
                  Icon(Icons.add_circle, color: Colors.blue),
                  SizedBox(width: 6),
                  Text("ADD EXAMS",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white),
              ),
              onPressed: submit,
              child: const Text("SUBMIT"),
            ),
          ],
        ),
      ),
    );
  }
}
