import 'package:flutter/material.dart';

import '../../../../dummydata/datas.dart';

class DeleteStudentwiseDetails extends StatefulWidget {
final String selectedClass;

  const DeleteStudentwiseDetails({super.key, required this.selectedClass});
  @override
  State<DeleteStudentwiseDetails> createState() =>
      _DeleteStudentwiseDetailsState();
}

class _DeleteStudentwiseDetailsState extends State<DeleteStudentwiseDetails> {
  late List<bool> selectedStatus;

  @override
  void initState() {
    super.initState();
    final students = classStudents[widget.selectedClass] ?? [];
    selectedStatus = List.generate(students.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final students = classStudents[widget.selectedClass] ?? [];
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: students.isEmpty
          ? Center(
              child: Text(
                "No students found for ${widget.selectedClass}",
                style: TextStyle(color: Colors.white),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                 Padding(
                   padding: const EdgeInsets.only(left: 8.0),
                   child: Text(
                      "Student Name",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                 ),
                Divider(thickness: 2),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          setState(() {
                            selectedStatus[index] = !selectedStatus[index];
                          });
                        },
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              selectedStatus[index] = !selectedStatus[index];
                            });
                          },
                          icon: selectedStatus[index]
                              ? Icon(Icons.check_box, color: Colors.green)
                              : Icon(
                                  Icons.check_box_outline_blank,
                                  color: Colors.white,
                                ),
                        ),
                        title: Text(
                          students[index],
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        Divider(thickness: 1, height: 5),
                    itemCount: students.length,
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.white, width: 2),
                      ),
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      final selectedStudents = [
                        for (int i = 0; i < students.length; i++)
                          if (selectedStatus[i]) students[i],
                      ];if(selectedStudents.isNotEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fees Standardisation Details Not Found")));
                        print("Selected Students: $selectedStudents");
                      } else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Select Student")));

                      }
                    },
                    child: Text("SUBMIT"),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
    );
  }
}
