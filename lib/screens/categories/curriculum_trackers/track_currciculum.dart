import 'package:flutter/material.dart';

import '../../../dummydata/datas.dart';

class TrackCurrciculum extends StatefulWidget {
  const TrackCurrciculum({super.key});

  @override
  State<TrackCurrciculum> createState() => _TrackCurrciculumState();
}

class _TrackCurrciculumState extends State<TrackCurrciculum> {
  String? selectedClass;
  String? selectedSub;


  void msgbox(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text("Message"),
          content: Text("No Information Available"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
          ],
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                      value: selectedSub,
                      isExpanded: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Select Subject',
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
                        selectedSub = value;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                msgbox();
                },
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
      ),
    );
  }
}
