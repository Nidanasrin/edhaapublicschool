import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddNew extends StatefulWidget {
  const AddNew({super.key});

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  final TextEditingController timeController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  Future<void> pickDate(TextEditingController controller) async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickDate != null) {
      String formattedDate = "${pickDate.day}/${pickDate.month}/${pickDate.year}";
      controller.text = formattedDate;
    }
  }

  Future<void> pickTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.pink,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      setState(() {
        timeController.text = time.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            buildLabelAndField("Task Title :", titleController, "Task Title"),
            const SizedBox(height: 10),
            Row(
              children: [
                const Expanded(
                  flex: 4,
                  child: Text("Date :", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                Expanded(
                  flex: 5,
                  child: TextField(
                    controller: dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today, color: Colors.blueGrey),
                        onPressed: () => pickDate(dateController),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      hintText: "dd/MM/yyyy",
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Expanded(
                  flex: 4,
                  child: Text("Time :", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                Expanded(
                  flex: 5,
                  child: TextField(
                    controller: timeController,
                    readOnly: true,
                    onTap: pickTime,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Select Time",
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: const Icon(Icons.access_time, color: Colors.indigo),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            buildLabelAndField("Comments :", commentsController, "Comments", maxLines: 3),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(color: Colors.white, width: 2),
                ),
                backgroundColor: Colors.blueGrey.shade900,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    dateController.text.isNotEmpty &&
                    timeController.text.isNotEmpty) {
                  final newList = {
                    "Task Title": titleController.text,
                    "Date": dateController.text,
                    "Time": timeController.text,
                    "Comments": commentsController.text,
                  };
                  Navigator.pop(context, newList);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("ToDo List Added Successfully")),
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: "Please fill all required fields (Title, Date & Time)",
                    gravity: ToastGravity.CENTER,
                    toastLength: Toast.LENGTH_SHORT,
                  );
                }
              },
              child: const Text("SUBMIT"),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildLabelAndField(String label, TextEditingController controller, String hintText, {int maxLines = 1}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 4,
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
      ),
      Expanded(
        flex: 5,
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
        ),
      ),
    ],
  );
}
