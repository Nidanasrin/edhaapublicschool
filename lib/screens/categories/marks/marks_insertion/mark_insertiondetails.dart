import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/subjects.dart';

class MarkInsertiondetails extends StatefulWidget {
  final String studentName;
  final String selectedClass;
  final String selectedExam;

  const MarkInsertiondetails({
    super.key,
    required this.studentName,
    required this.selectedClass,
    required this.selectedExam,
  });
  @override
  State<MarkInsertiondetails> createState() => _MarkInsertiondetailsState();
}

class _MarkInsertiondetailsState extends State<MarkInsertiondetails> {
  String? selectedSub;
  Map<String, int> selectedMarks = {};

  void markBox(String sub) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade900,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "SELECT MARKS",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 300,
                  child: GridView.builder(
                    itemCount: 26, // 0 to 25 marks
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 15,
                      childAspectRatio: 2.5,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Set selected mark for this subject
                          setState(() {
                            selectedMarks[sub] = index;
                          });
                          Navigator.pop(context);
                        },
                        child:  Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '$index',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void msgBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: Colors.white,
        title: Text("Message"),
        content: Text("Please map exams and subjects"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK", style: TextStyle(color: Colors.indigo.shade900)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo.shade900,
        centerTitle: true,
        title: Text(widget.studentName, style: TextStyle(fontSize: 17)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Row(
              children: [
                Text("Exam Name", style: TextStyle(color: Colors.white)),
                Text(
                  ": ${widget.selectedExam}",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Divider(thickness: 1, height: 0),
          ListTile(
            title: Row(
              children: [
                Text("Class Name", style: TextStyle(color: Colors.white)),
                Text(
                  ": ${widget.selectedClass}",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            height: 35,
            decoration: BoxDecoration(
              color: Colors.indigo.shade900,
              shape: BoxShape.rectangle,
            ),
            child: Row(
              children: [
                SizedBox(width: 5),
                Text(
                  "Subject",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(width: 170),
                Text(
                  "Maximum Marks",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(width: 30),
                Text(
                  "Marks Obtained",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          if (widget.selectedClass == "DAY CARE")
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Text("ENGLISH", style: TextStyle(color: Colors.white)),
                        SizedBox(width: 170),
                        Text("25", style: TextStyle(color: Colors.white)),
                        SizedBox(width: 30),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blueGrey.shade900,
                          child: Text(
                            "${index + 10}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          else if (widget.selectedClass == "GRADE-3")
            Expanded(
              child: ListView.builder(
                itemCount: grade3Sub.length,
                itemBuilder: (context, index) {
                  final sub = grade3Sub[index];
                  return ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            sub,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "25",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () =>
                                markBox(sub), // Pass the subject to the dialog
                            child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                selectedMarks[sub]?.toString() ?? '',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          else
            FutureBuilder(
              future: Future.delayed(Duration.zero, () => msgBox()),
              builder: (context, snapshot) {
                return const SizedBox.shrink(); // Placeholder
              },
            ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white, width: 2),
              ),
              onPressed: () {
                if (selectedSub == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select at least one subject marks"),
                    ),
                  );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(backgroundColor: Colors.green,
                      content: Text("Marks Added Successfully"),
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text("SUBMIT"),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
