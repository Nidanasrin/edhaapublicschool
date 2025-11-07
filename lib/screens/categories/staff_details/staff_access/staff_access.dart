import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';

class StaffAccess extends StatefulWidget {
  const StaffAccess({super.key});

  @override
  State<StaffAccess> createState() => _StaffAccessState();
}

class _StaffAccessState extends State<StaffAccess> {
  String? selectedTeacher;
  Map<String, List<bool>> teacherAccessMap = {}; // Store checkbox states for each teacher
  List<bool> selectedList = [];

  @override
  void initState() {
    super.initState();

    // Initialize teacherAccessMap for each teacher
    for (var teacher in teachers) {
      // Ensure the list length matches `list.length`
      teacherAccessMap[teacher] = List.generate(list.length, (_) => false);
    }

    // Set default selected teacher
    if (teachers.isNotEmpty) {
      selectedTeacher = teachers[0];
      selectedList = List.from(teacherAccessMap[selectedTeacher]!);
    }
  }

  void _updateSelectedListForTeacher(String teacher) {
    if (teacherAccessMap.containsKey(teacher)) {
      // Make sure the list length matches `list.length`
      if (teacherAccessMap[teacher]!.length != list.length) {
        teacherAccessMap[teacher] = List.generate(list.length, (_) => false);
      }
      selectedList = List.from(teacherAccessMap[teacher]!);
    } else {
      teacherAccessMap[teacher] = List.generate(list.length, (_) => false);
      selectedList = List.from(teacherAccessMap[teacher]!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    "Select Staff",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: DropdownButtonFormField<String>(
                    value: selectedTeacher,
                    isExpanded: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Select Staff",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    items: teachers
                        .map((teacher) => DropdownMenuItem<String>(
                      value: teacher,
                      child: Text(
                        teacher,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedTeacher = value;
                        _updateSelectedListForTeacher(selectedTeacher!);
                      });
                    },
                  ),
                ),
              ],
            ),
            Divider(thickness: 1, height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: list.length,
                separatorBuilder: (context, index) =>
                    Divider(thickness: 1, height: 0),
                itemBuilder: (context, index) {
                  final staffItem = list[index];
                  return ListTile(
                    leading: Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.green,
                      value: selectedList.length > index
                          ? selectedList[index]
                          : false,
                      onChanged: (value) {
                        setState(() {
                          if (selectedList.length > index) {
                            selectedList[index] = value!;
                          } else {
                            // Safety: expand list if necessary
                            selectedList.add(value!);
                          }
                          teacherAccessMap[selectedTeacher!] =
                              List.from(selectedList);
                        });
                      },
                    ),
                    title: Text(
                      staffItem,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    title: Text("Message"),
                    content: Text("Staff Access Updated Successfully"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.indigo.shade900),
                        ),
                      )
                    ],
                  ),
                );
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
    );
  }
}
