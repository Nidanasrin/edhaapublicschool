import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../dummydata/datas.dart';

class MarksCreation extends StatefulWidget {
  const MarksCreation({super.key});

  @override
  State<MarksCreation> createState() => _MarksCreationState();
}

class _MarksCreationState extends State<MarksCreation> {
  String? selectedClass;
  String? selectedSubject;
  String? selectedExam;
  DateTime? fromDate;
  DateTime? toDate;
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  List<String?> selectedSubjects = [];
  List<TextEditingController> controllers = [];

  Future<void> _pickDate(TextEditingController controller, bool isFrom) async {
    DateTime initialDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
        if (isFrom) {
          fromDate = pickedDate;
        } else {
          toDate = pickedDate;
        }
      });
    }
  }

  @override
  void dispose() {
    fromDateController.dispose();
    toDateController.dispose();
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void addField() {
    setState(() {
      controllers.add(TextEditingController());
      selectedSubjects.add(null);
    });
  }

  void submit() {
    if (selectedClass == null ||
        selectedExam == null ||
        fromDate == null ||
        toDate == null ||
        selectedSubjects.any((s) => s == null) ||
        controllers.any((c) =>
        c.text
            .trim()
            .isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all the details")),
      );
      return;
    }
    List<Map<String,dynamic>> subjectMarks = [];
    for(int i=0;i < controllers.length;i++){
      subjectMarks.add({
        "subject" : selectedSubjects[i],
        "maxMArks" : controllers[i].text.trim(),
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.green,
      content: Text("Exams Created Successfully"),
    ));
    Navigator.pop(context, {
      "class": selectedClass,
      "exam": selectedExam,
      "fromDate": fromDate,
      "toDate": toDate,
      "subjects": subjectMarks,
    });
  }

  @override
  void initState() {
    super.initState();
    addField(); // add first field by default
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildRowDropDown(
              "Select Class                               :","Select Class",
              selectedClass,
              list,
                  (value) {
                setState(() => selectedClass = value);
              },
            ),
            SizedBox(height: 10,),
            buildRowDropDown(
              "Select Exam                               :","Select Exam",
              selectedExam,
              exams,
                  (value) {
                setState(() => selectedExam = value);
              },
            ),
            SizedBox(height: 10,),
            dateField("From Date", fromDateController, true),
            SizedBox(height: 20),
            dateField("To Date", toDateController, false),
            SizedBox(height: 10,),
            Container(padding: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,color: Colors.green.shade900,
              ),child: Row(
              children: [
                SizedBox(width: 5,),
                Text("Subject",style: TextStyle(color: Colors.white,fontSize: 16),),
                SizedBox(width: 170,),
                Text("Max Marks",style: TextStyle(color: Colors.white,fontSize: 16),)
              ],
            ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: DropdownButtonFormField<String>(
                            value: selectedSubjects[index],
                            isExpanded: true,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Subject",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                            ),
                            items: subjects
                                .map((e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e, style: TextStyle(color: Colors.black)),
                            ))
                                .toList(),
                            onChanged: (value){
                              setState(() {
                                selectedSubjects[index] = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(flex: 3,
                          child: TextField(
                                                controller: controllers[index],
                                                style: const TextStyle(color: Colors.white),
                                                decoration: InputDecoration(
                          hintText: "Max Marks",
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
                                selectedSubjects.removeAt(index);
                              });
                            },
                          )
                              : null,
                                                ),
                                              ),
                        ),
                    ]
                  )
                  );
                },
              ),
            ),
             SizedBox(width: 12),
            GestureDetector(
              onTap: addField,
              child: Row(
                children: const [
                  Icon(Icons.add_circle, color: Colors.blue),
                  SizedBox(width: 6),
                  Text("ADD SUBJECTS",
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
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
Widget buildRowDropDown(
    String title,
    String hintText,
    String? selectedValue,
    List<String> items,
    ValueChanged<String?> onChanged,
    ) {
  return Row(
    children: [
      Expanded(
        flex: 5,
        child: Text(title, style: TextStyle(color: Colors.white,fontSize: 16)),
      ),
      Expanded(
        flex: 5,
        child: DropdownButtonFormField<String>(
          value: selectedValue,
          isExpanded: true,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(color: Colors.black)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    ],
  );
}
Widget dateField(String hintText, TextEditingController controller, bool isFrom) {
  return Row(
    children: [
      Expanded(
        flex: 5,
        child: TextField(
          onTap: ()=>_pickDate(controller, isFrom),
          controller: controller,
          readOnly: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.blueGrey[800],
            suffixIcon: IconButton(
              icon: Icon(Icons.calendar_today, color: Colors.white),
              onPressed: () => _pickDate(controller, isFrom),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    ],
  );
}
}