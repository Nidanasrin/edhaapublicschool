import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'package:raynottschool/screens/categories/attendence/face_attendance/cutofftime_2.dart';

class Setcutofftime extends StatefulWidget {
  final List<String> staffList;
  final List<String> classList;

  const Setcutofftime({super.key, required this.staffList, required this.classList});


  @override
  State<Setcutofftime> createState() => _SetcutofftimeState();
}

class _SetcutofftimeState extends State<Setcutofftime> {
  String? selectedValue;
  String? selectedClass;
  bool isLoading = false;
  Map<String,TimeOfDay?> selectedTimes = {};

  Future<void> pickTime(String name) async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.pink, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.pink, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      setState(() {
        selectedTimes[name] = time;
      });
    }
  }

  void msgBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        title: Text("Message"),
        content: Text("Cut Off Time Updated Successfully"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text("OK", style: TextStyle(color: Colors.indigo.shade900)),
          ),
        ],
      ),
    );
  }


  Future<void> saveToFirebase()async{
    setState(() {
      isLoading = true;
    });
    try {
      Map<String, String> dataToSave = {};
      selectedTimes.forEach((key, value) {
        if (value != null) {
          dataToSave[key] = value != null ? value!.format(context) : "";
        }
      });
      await FirebaseFirestore.instance
          .collection('attendance')
          .doc('face_attendance')
          .collection('Cut Off Time')
          .doc(selectedValue)
          .set(dataToSave);

      msgBox();
    } catch (e) {
      print('Error : $e');
    } finally {
      isLoading = false;
    }
  }
  void navigateBaseOnSelection(){
    TextEditingController timeController = TextEditingController();

    TimeOfDay? selectedTime;
      showDialog(context: context, builder: (context)=>
      AlertDialog(
        backgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        title: Text("Set Cut-Off Time"),
        content: TextField(
          controller: timeController,
          readOnly: true, // so user can't type
          onTap: () async {
            selectedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (selectedTime != null) {
              setState(() {
                timeController.text = selectedTime!.format(context);
              });
            }
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "Select Time",
            suffixIcon: const Icon(Icons.access_time, color: Colors.indigo),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        actions: [
      ElevatedButton(
      style: ElevatedButton.styleFrom(
      shape:
      RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.indigo.shade900, width: 2),
      ), backgroundColor: Colors.grey.shade200,
    foregroundColor: Colors.black
    ), onPressed: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cut Off Time Updated Successfully")));
      }, child: Text("SUBMIT"),
      )
        ],
      ));
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  children: [
                    Expanded(flex: 4,
                        child: Text("Select                    :",
                          style: TextStyle(
                              color: Colors.white, fontSize: 18),)),
                    Expanded(flex: 5,
                      child: DropdownButtonFormField<String>(
                          value: selectedValue,
                          isExpanded: true,
                          decoration: InputDecoration(fillColor: Colors.white,
                              filled: true, hintText: "Select ",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                          items: ["Staff", "Class","Absentee Students"].map((value) =>
                             DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value, style: TextStyle(color: Colors.black),)
                            )
                          ).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                          }),
                    ),
                  ]
              ),
              SizedBox(height: 60.0,),
              Center(
                child:
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape:
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.white, width: 2),
                        ), backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white
                    ),
                    onPressed: (){
                      if (selectedValue == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please select an option")),
                        );
                        return;
                      }

                if (selectedValue == "Staff") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Cutofftime2(
                        selectedOption: selectedValue!,
                        items: widget.staffList,
                      ),
                    ),
                  );
              } else if (selectedValue == "Class") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Cutofftime2(
                        selectedOption: selectedValue!,
                        items: widget.classList, // <-- use class names list here
                      ),
                    ),
                  );
      } else if (selectedValue == "Absentee Students") {
        navigateBaseOnSelection();
      }
                    }, child: Text("SUBMIT")),
              ),
              SizedBox(height: 15,),
            ],
          ),
        ),
      );
    }
  }
