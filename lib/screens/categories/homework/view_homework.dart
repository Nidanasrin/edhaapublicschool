import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../dummydata/datas.dart';

class ViewHomework extends StatefulWidget {
  const ViewHomework({super.key});

  @override
  State<ViewHomework> createState() => _ViewHomeworkState();
}

class _ViewHomeworkState extends State<ViewHomework> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;
  String? selectedClass;
  String? selectedSubject;

  void msgBox(){
    showDialog(context: context, builder: (context)=>
    AlertDialog(backgroundColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text("Message",),
      content: Text("No Homeworks Found",style: TextStyle(fontSize: 15),),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
      ],
    ));
  }

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                rowField(
                  title: "Select Class",
                  hintText: "Select Class",
                  value: selectedClass,
                  items: list,
                  onChanged: (value) {
                    setState(() {
                      selectedClass = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                rowField(
                  title: "Select Subject",
                  hintText: "Select Subject",
                  value: selectedSubject,
                  items: subjects,
                  onChanged: (value) {
                    setState(() {
                      selectedSubject = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                dateField("From Date", fromDateController, true),
                SizedBox(height: 20),
                dateField("To Date", toDateController, false),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    msgBox();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: BorderSide(color: Colors.white),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text("SUBMIT", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
    );
  }

  Widget rowField({
    required String title,
    required String hintText,
    String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Row(
      children: [
        Expanded(
            flex: 4,
            child: Text(title, style: TextStyle(color: Colors.white, fontSize: 18))),
        SizedBox(width: 10),
        Expanded(
          flex: 5,
          child: DropdownButtonFormField<String>(
            value: value,
            isExpanded: true,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: hintText,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
            items: items
                .map((e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e, style: TextStyle(color: Colors.black)),
            ))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget dateField(String title, TextEditingController controller, bool isFrom) {
    return Row(
      children: [
        Expanded(
            flex: 4,
            child: Text(title, style: TextStyle(color: Colors.white,fontSize: 16))),
        SizedBox(width: 10),
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
              hintText: 'dd/MM/yyyy',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
