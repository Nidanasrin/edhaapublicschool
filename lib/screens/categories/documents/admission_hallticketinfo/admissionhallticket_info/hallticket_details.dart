import 'package:flutter/material.dart';
import '../../../../../dummydata/datas.dart';

class HallticketDetails extends StatefulWidget {
  final String selectedClass;

  const HallticketDetails({super.key, required this.selectedClass});

  @override
  State<HallticketDetails> createState() => _HallticketDetailsState();
}

class _HallticketDetailsState extends State<HallticketDetails> {
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
      appBar: AppBar(
        title: Text('Hall Ticket Numbers'),
        backgroundColor: Colors.blueGrey.shade700,
      ),
      body: students.isEmpty
          ? const Center(
        child: Text(
          'No students found',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      )
          : SafeArea(
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
                    hintText: "Hall Ticket Number",
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
    );
  }
}
