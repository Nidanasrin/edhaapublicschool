import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TodoDetails extends StatefulWidget {
  final Map<String, dynamic> task;
  final Function(Map<String, dynamic>)? onUpdate;
  final Function()? onDelete;
  final Function()? onComplete;

  const TodoDetails({
    super.key,
    required this.task,
    this.onUpdate,
    this.onDelete,
    this.onComplete,
  });

  @override
  State<TodoDetails> createState() => _TodoDetailsState();
}

class _TodoDetailsState extends State<TodoDetails> {
  late TextEditingController titleController;
  late TextEditingController dateController;
  late TextEditingController timeController;
  late TextEditingController commentsController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task['Task Title']);
    dateController = TextEditingController(text: widget.task['Date']);
    timeController = TextEditingController(text: widget.task['Time']);
    commentsController = TextEditingController(text: widget.task['Comments']);
  }

  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    timeController.dispose();
    commentsController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
        final formattedTime = pickedTime.format(context);

        setState(() {
          dateController.text = formattedDate;
          timeController.text = formattedTime;
        });

        // update task map and send back
        final updatedTask = {
          'Task Title': titleController.text,
          'Date': formattedDate,
          'Time': formattedTime,
          'Comments': commentsController.text,
        };

        Navigator.pop(context, updatedTask);
      }
    }
  }

@override
Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
     body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            buildDetailRow("Task Title", titleController),
            const SizedBox(height: 10),
            buildDetailRow("Date", dateController),
            const SizedBox(height: 10),
            buildDetailRow("Time", timeController),
            const SizedBox(height: 10),
            buildDetailRow("Comments", commentsController, multiLine: true),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("DELETE", Colors.red, widget.onDelete ?? () {
                  Navigator.pop(context, 'delete');
                }),
                buildButton("RESCHEDULED", Colors.orange, _pickDateTime),
                buildButton("COMPLETED", Colors.green, widget.onComplete ?? () {
                  Navigator.pop(context, 'complete');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String label,TextEditingController controller, {bool multiLine = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3,
            child: Text("$label :", style: const TextStyle(color: Colors.white, fontSize: 16))),
        const SizedBox(width: 10),
        Expanded(flex: 5,
            child: TextField(
    controller: controller,
    decoration: InputDecoration(
    fillColor: Colors.white,
    filled: true,
    hintText: "",
    border: OutlineInputBorder(),
    ),
    ),
    ),
      ],
    );
  }

  Widget buildButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey.shade900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(color: Colors.white, width: 2),
        ),
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}