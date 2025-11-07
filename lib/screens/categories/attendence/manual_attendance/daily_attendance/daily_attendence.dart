import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/attendence/manual_attendance/daily_attendance/dailyattendence_detail.dart';

import '../../../../../dummydata/datas.dart';

class DailyAttendence extends StatefulWidget {
  const DailyAttendence({super.key});

  @override
  State<DailyAttendence> createState() => _DailyAttendenceState();
}

class _DailyAttendenceState extends State<DailyAttendence> {
  TextEditingController dateController = TextEditingController();
  String? selectedValue;
  Future<void> pickDate(TextEditingController controller,bool isFromDate)async{
DateTime? pickDate = await showDatePicker(context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000), lastDate: DateTime(2100));
if(pickDate!=null){
  String formattedDate = "${pickDate.day}/${pickDate.month}/${pickDate.year}";
  controller.text = formattedDate;
}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueGrey.shade900,
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                children: [
                  Expanded(flex: 4,child: Text("Class name       :",style: TextStyle(color: Colors.white,fontSize: 18),)),
                  Expanded(flex: 5,
                    child: DropdownButtonFormField<String>(
                        value: selectedValue,isExpanded: true,
                        decoration: InputDecoration(fillColor: Colors.white,
                            filled: true,hintText: "Select Class",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                        items: list.map((String value){
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,style: TextStyle(color: Colors.black),)
                          );
                        }).toList(),
                        onChanged: (value){
                          setState(() {
                            selectedValue = value;
                          });
                        }),
                  ),
                ]
            ),
            SizedBox(height: 20.0,),
            Row(
              children: [
            Expanded(flex: 4,
                child: Text("Date                   :", style: TextStyle(color: Colors.white,fontSize: 18))),

            Expanded(flex: 5,
              child: TextField(
                controller: dateController,
                readOnly: true,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.blueGrey),
                    onPressed: () => pickDate(dateController, true),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),),
                  hintText: "dd/MM/yyyy",
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
            ]
            ),
            SizedBox(height: 60.0,),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape:
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.white,width: 2),
                      ),backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white
                  ),
                  onPressed: (){
                    if(selectedValue != null || dateController.text.isNotEmpty){
                      final students
                      = list;
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> dailyAttendenceDetail(className: selectedValue!, students: students, date: dateController.text)));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Select a Class and Date.")));
                    }
                  }, child: Text("SUBMIT")),
            )

          ],
        ),
      ),
    );
  }
}
