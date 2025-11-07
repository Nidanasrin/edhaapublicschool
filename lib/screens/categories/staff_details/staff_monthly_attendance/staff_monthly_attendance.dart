import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'package:raynottschool/screens/categories/staff_details/staff_attendance/staff_attendance.dart';
import 'package:raynottschool/screens/categories/staff_details/staff_monthly_attendance/staff_attendance_details.dart';

class StaffMonthlyAttendance extends StatefulWidget {
  const StaffMonthlyAttendance({super.key});

  @override
  State<StaffMonthlyAttendance> createState() => _StaffMonthlyAttendanceState();
}

class _StaffMonthlyAttendanceState extends State<StaffMonthlyAttendance> {
  String? selectedMonth;
  String? selectedStaff;
  String? selectedYear;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildRowDropDown(
                      "Select Staff                  :","Select Staff",
                      selectedStaff,
                      staffNames,
                          (value) {
                        setState(() => selectedStaff = value);
                      },
                    ),
                    SizedBox(height: 10,),
                    buildRowDropDown(
                      "Select Month               :","Select Month",
                      selectedMonth,
                      month,
                          (value) {
                        setState(() => selectedMonth = value);
                      },
                    ),
                    SizedBox(height: 10,),
                    buildRowDropDown(
                      "Select Year                   :","Select Year",
                      selectedYear,
                      year,
                          (value) {
                        setState(() => selectedYear = value);
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(5)),
                        backgroundColor: Colors.blueGrey.shade900,
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white,width: 2),
                      ),
                      onPressed: (){
                        if(selectedStaff==null || selectedMonth == null || selectedYear == null){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please Select Staff,Month and Year ",style: TextStyle(fontWeight: FontWeight.bold),)),
                          );
                        }else{
                         Navigator.push(context, MaterialPageRoute(builder: (context)=> StaffAttendanceDetails(staffName: selectedStaff!,)));
    }
                      },
                      child: const Text("SUBMIT"),
                    ),
                  ])
          ),
        )
    );
  }
}
Widget buildRowDropDown(
    String title,
    String hintText,
    String? selectedValue,
    List<String> items,
    ValueChanged<String?> onChanged,
    ) {
  return Row(
    children: [
      Expanded(
        flex: 5,
        child: Text(title, style: TextStyle(color: Colors.white,fontSize: 16)),
      ),
      Expanded(
        flex: 5,
        child: DropdownButtonFormField<String>(
          value: selectedValue,
          isExpanded: true,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(color: Colors.black)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    ],
  );
}

