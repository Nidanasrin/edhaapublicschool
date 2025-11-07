import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/attendence/manual_attendance/attendence_reports/attendance_reports_2.dart';
class AttendanceReports extends StatefulWidget {
  const AttendanceReports({super.key});

  @override
  State<AttendanceReports> createState() => _AttendanceReportsState();
}

class _AttendanceReportsState extends State<AttendanceReports> {
  TextEditingController dateController = TextEditingController();

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
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    if( dateController.text.isNotEmpty){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AttendanceReports2()));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Select A Date.")));
                    }
                  }, child: Text("SUBMIT")),
            )

          ],
        ),
      ),

    );
  }
}
