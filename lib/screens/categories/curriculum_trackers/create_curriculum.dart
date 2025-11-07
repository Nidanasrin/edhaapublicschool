import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../dummydata/datas.dart';

class CreateCurriculum extends StatefulWidget {
  const CreateCurriculum({super.key});

  @override
  State<CreateCurriculum> createState() => _CreateCurriculumState();
}

class _CreateCurriculumState extends State<CreateCurriculum> {
  String? selectedClass;
  String? selectedsub;
  String? selectedteacher;
  DateTime? _startDate;
  DateTime? _endDate;
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  TextEditingController teachingController = TextEditingController();
  TextEditingController periodController = TextEditingController();
  TextEditingController curriculumController = TextEditingController();
  TextEditingController commentsController = TextEditingController();

  void msgbox(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text("Message"),
          content: Text("Please Fill All Details"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
          ],
        )
    );
  }
  void msgbox2(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text("Message"),
          content: Text("Curriculum Created Successfully"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
          ],
        )
    );
  }
  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.indigo.shade400,
              onPrimary: Colors.white,
              surface: Colors.blueGrey.shade800,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _handleSubmit() {
    if (selectedClass == null ||
        selectedsub == null ||
        selectedteacher == null ||
        _startDate == null ||
        _endDate == null ||
        teachingController.text.isEmpty ||
        periodController.text.isEmpty ||
        curriculumController.text.isEmpty ||
        commentsController.text.isEmpty) {
      msgbox();
    } else {
      msgbox2();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    "Class Name",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: DropdownButtonFormField<String>(
                    value: selectedClass,
                    isExpanded: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Class Name",
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 3,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    items: list.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedClass = value;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    "Select Subject",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: DropdownButtonFormField<String>(
                    value: selectedsub,
                    isExpanded: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Select',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 3,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    items: subjects.map((String student) {
                      return DropdownMenuItem<String>(
                        value: student,
                        child: Text(
                          student,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedsub = value;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    "Select Teacher",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: DropdownButtonFormField<String>(
                    value: selectedteacher,
                    isExpanded: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Select',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 3,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    items: teachers.map((String student) {
                      return DropdownMenuItem<String>(
                        value: student,
                        child: Text(
                          student,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedteacher = value;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                const Expanded(
                  flex: 5,
                  child: Text(
                    "Start Date",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: GestureDetector(
                    onTap: () => _selectDate(context, true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Text(
                        _startDate == null
                            ? "Select Date"
                            : dateFormat.format(_startDate!),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // End Date
            Row(
              children: [
                const Expanded(
                  flex: 5,
                  child: Text(
                    "End Date",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: GestureDetector(
                    onTap: () => _selectDate(context, false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Text(
                        _endDate == null
                            ? "Select Date"
                            : dateFormat.format(_endDate!),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            buildRow("No:of Teaching Days", "No:of Days", teachingController),
            SizedBox(height: 10,),
            buildRow("No:of Periods", "No:of Periods", periodController),
            SizedBox(height: 10,),
            buildRow("Curriculum", "Curriculum", curriculumController),
            SizedBox(height: 10,),
            buildRow("Comments", "Comments", commentsController),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed:
                _handleSubmit              ,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.blueGrey.shade900,
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white, width: 2),
              ),
              child: const Text("SUBMIT"),
            ),
          ],
        ),
      ),
    );
  }
}
Widget buildRow(String title,String hintText,TextEditingController controller){
  return  Row(
    children: [
      Expanded(
        flex: 5,
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),),
      Expanded(
        flex: 5,
        child: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,hintText: hintText,hintStyle: TextStyle(color: Colors.grey),
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5)),
          ),
        ),
      ),
    ],
  );
}