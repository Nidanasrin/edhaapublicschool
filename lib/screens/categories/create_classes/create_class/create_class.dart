import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';

import 'create_class2.dart';

class CreateClass extends StatefulWidget {
  const CreateClass({super.key});

  @override
  State<CreateClass> createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  String? selectedClass;
  final TextEditingController _editController = TextEditingController();

  void editDialog(String selClass) {
    _editController.text = selClass;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.indigo.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(flex: 2,
                  child: Text(
                    "Class Name : ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(flex: 4,
                  child: TextField(
                    controller: _editController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: selectedClass,
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                ]
            ),
                SizedBox(height: 15,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo.shade900,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(width: 2, color: Colors.white),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      // 1️⃣ Find the position (index) of the old class name in the list
                      int index = list.indexOf(selClass);

                      // 2️⃣ If found, replace it with the new class name entered by the user
                      if (index != -1) {
                        list[index] = _editController.text;
                      }
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'UPDATE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
        ),
      ),
    );
  }

  void optionDialog(String className) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.indigo.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 2, color: Colors.indigo.shade900),
                ),
              ),
              onPressed: () {
                editDialog(className);
              },
              child: const Text(
                'EDIT',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.indigo.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 2, color: Colors.indigo.shade900),
                ),
              ),
              onPressed: () {
                setState(() {
                  list.remove(className);
                });
                Navigator.pop(context);
              },
              child: const Text(
                'DELETE',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                final item = list[index];
                return ListTile(
                  onTap: () {
                    optionDialog(item);
                  },
                  title: Text(
                    item,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                );
              },
              separatorBuilder: (context, _) =>
                  Divider(height: 0, color: Colors.white, thickness: 1),
              itemCount: list.length,
            ),
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey.shade900,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 2, color: Colors.white),
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateClass2()));
              },
              child: const Text(
                'CREATE CLASS',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
