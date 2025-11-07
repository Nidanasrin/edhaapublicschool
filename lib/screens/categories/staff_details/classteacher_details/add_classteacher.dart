import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';

class AddClassteacher extends StatefulWidget {
  final Map<String, String>? existingMap;
  const AddClassteacher({super.key, this.existingMap});
  @override
  State<AddClassteacher> createState() => _AddClassteacherState();
}

class _AddClassteacherState extends State<AddClassteacher> {
  late Map<String, String> tempMap;

  @override
  void initState() {
    super.initState();
    // Copy existing selections if any
    tempMap = Map.from(widget.existingMap ?? {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Expanded(
            child: ListView.separated(
              itemCount: teachers.length,
              separatorBuilder: (context, index) => const Divider(
                thickness: 1,
                height: 0,
                color: Colors.white24,
              ),
              itemBuilder: (context, index) {
                final className = list[index];
                final selectedTeacher = tempMap[className];

                return ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          className,
                          style: const TextStyle(color: Colors.white),
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
                          items: staffNames
                              .map((staff) => DropdownMenuItem<String>(
                            value: staff,
                            child: Text(
                              staff,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value != null) tempMap[className] = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                // Return the selected class-teacher map
                Navigator.pop(context, tempMap);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.blueGrey.shade900,
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white, width: 2),
              ),
              child: const Text("SUBMIT"),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
