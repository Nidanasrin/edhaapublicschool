import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:raynottschool/dummydata/datas.dart';

class CreateClass2 extends StatefulWidget {
  const CreateClass2({super.key});

  @override
  State<CreateClass2> createState() => _CreateClass2State();
}

class _CreateClass2State extends State<CreateClass2> {
  TextEditingController classController = TextEditingController();
  TextEditingController countController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "Class Name",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: classController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    hintText: "Enter Class Name",
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "Student Count",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: countController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    hintText: "StudentCount",
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey.shade900,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(width: 2, color: Colors.white),
              ),
            ),
            onPressed: () {
              if(classController.text.trim().isEmpty || countController.text.trim().isEmpty ){
                Fluttertoast.showToast(msg:  "Please fill all the details",
                    fontSize: 16,textColor: Colors.white,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.red,
                    toastLength: Toast.LENGTH_SHORT);
              }else{
                setState(() {
                  list.add(classController.text.trim());
                });
                    Fluttertoast.showToast(msg:  "Class Created Successfully",
                    fontSize: 16,
                    gravity: ToastGravity.CENTER,textColor: Colors.white,
                    backgroundColor: Colors.green,
                    toastLength: Toast.LENGTH_SHORT);
              }
              classController.clear();
              countController.clear();
            },
            child: const Text(
              'SUBMIT',
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
