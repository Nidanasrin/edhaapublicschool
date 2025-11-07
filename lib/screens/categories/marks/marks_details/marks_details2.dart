import 'package:flutter/material.dart';
import '../../../../dummydata/subjects.dart';

class MarksDetails2 extends StatefulWidget {
  final String studentName;
  final String selectedClass;
  final String selectedExam;

  const MarksDetails2({
    super.key,
    required this.studentName,
    required this.selectedClass,
    required this.selectedExam,
  });

  @override
  State<MarksDetails2> createState() => _MarksDetails2State();
}

class _MarksDetails2State extends State<MarksDetails2> {
  Map<String, int> selectedMarks = {};
  String? selectedSub;

  void markBox(String sub) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade900,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "SELECT MARKS",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 250,
                  child: GridView.builder(
                    itemCount: 26,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 2,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSub = sub;
                            selectedMarks[sub] = index;
                          });
                          Navigator.pop(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: selectedMarks[sub] == index
                              ? Colors.indigo
                              : Colors.transparent,
                          child: Text(
                            "$index",
                            style: const TextStyle(color: Colors.white),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.share))
        ],
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo.shade900,
        centerTitle: true,
        title: Text(widget.studentName, style: const TextStyle(fontSize: 17)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Row(
              children: [
                Expanded(flex: 2,
                    child: const Text("Exam Name", style: TextStyle(color: Colors.white))),
                Expanded(flex: 4,
                  child: Text(": ${widget.selectedExam}",
                      style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          const Divider(thickness: 1, height: 0),
          ListTile(
            title: Row(
              children: [
                Expanded(flex: 2,
                    child: const Text("Class Name", style: TextStyle(color: Colors.white))),
                Expanded(flex: 4,
                  child: Text(": ${widget.selectedClass}",
                      style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          const Divider(thickness: 1, height: 0),
          ListTile(
            title: Row(
              children: [
                Expanded(flex: 2,
                    child: const Text("Total Marks", style: TextStyle(color: Colors.white))),
                Expanded(flex: 1,
                  child: Text(": 25",
                      style: const TextStyle(color: Colors.white)),
                ),
                Expanded(flex: 2,
                    child: Text("Marks Obtained", style: TextStyle(color: Colors.white))),
                Expanded(flex: 1,
                  child: Text(": 12.0",
                      style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ), Divider(thickness: 1, height: 0),
          ListTile(
            title: Row(
              children: [
                Expanded(flex: 2,
                    child: const Text("Percentage", style: TextStyle(color: Colors.white))),
                Expanded(flex: 4,
                  child: Text(": 50%",
                      style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          const Divider(thickness: 1, height: 0),
          Container(
            height: 50,
            decoration: BoxDecoration(color: Colors.indigo.shade900),
            child: const Row(
              children: [
                SizedBox(width: 10),
                Expanded(
                  flex: 4,
                  child: Text("Subject",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                Expanded(
                  flex: 3,
                  child: Text("Maximum Marks",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                Expanded(
                  flex: 3,
                  child: Text("Marks Obtained",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            ),
          ),Divider(thickness: 1, height: 0),
          const SizedBox(height: 5),

          // For GRADE-3
          if (widget.selectedClass == "GRADE-3")
            Expanded(
              child: ListView.builder(
                itemCount: grade3Sub.length,
                itemBuilder: (context, index) {
                  final sub = grade3Sub[index];
                  return ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(sub,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16)),
                        ),
                        const Expanded(
                          flex: 2,
                          child: Text("25",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16)),
                        ),
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () => markBox(sub),
                            child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                Border.all(width: 2, color: Colors.white),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                selectedMarks[sub]?.toString() ?? '',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
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
          else if (widget.selectedClass == "DAY CARE")
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text("ENGLISH",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16)),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text("25",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text("10",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
SizedBox(height: 15,),
Center(
  child: Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(backgroundColor: Colors.transparent,
          backgroundImage: AssetImage("assets/images/app_sms.png"),
        ),
        SizedBox(width: 25,),
        CircleAvatar(backgroundColor: Colors.transparent,
          backgroundImage: AssetImage("assets/images/bell (1).png"),
        ),SizedBox(width: 25,),
        CircleAvatar(backgroundColor: Colors.transparent,
          backgroundImage: AssetImage("assets/images/phone.png"),
        ),
      ],
      ),
),

           SizedBox(height: 20),
        ],
      ),
    );
  }
}
