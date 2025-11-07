import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/attendence/manual_attendance/set_holidays/set_holiday_2.dart';

class SetHoliday extends StatefulWidget {
  const SetHoliday({super.key});

  @override
  State<SetHoliday> createState() => _SetHolidayState();
}

class _SetHolidayState extends State<SetHoliday> {
  TextEditingController dateController = TextEditingController();
  Future<void> pickDate(TextEditingController controller,bool isFromDate)async{
    DateTime? pickDate = await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000), lastDate: DateTime(2100));
    if(pickDate!=null){
      String formattedDate = "${pickDate.month} ${pickDate.year}";
      controller.text = formattedDate;
    }
  }
  String? selectedMonth;
  String? selectedYear;
  List<String> month = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  List<String> year = [
    "2026",
    "2025",
    "2024",
    "2023",
    "2022",
    "2021",
    "2020",
    "2019",
    "2018",
    "2017",
    "2016",
    "2015",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "Select Month       :",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),

                Expanded(
                  flex: 5,
                  child: DropdownButtonFormField<String>(
                    value: selectedMonth,
                    isExpanded: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Select Month",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    items: month.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMonth = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "Select Year            :",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),

                Expanded(
                  flex: 5,
                  child: DropdownButtonFormField<String>(
                    value: selectedYear,
                    isExpanded: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Select Year",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    items: year.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedYear = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 60.0),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.white, width: 2),
                  ),
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  if ( selectedMonth != null || selectedYear !=null) {
                    final selectedDate = "${selectedMonth!} ${selectedYear!}";

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SetHoliday2(month: selectedMonth!, year: int.parse(selectedYear!),)
                        )
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please select the options"),
                      ),
                    );
                  }
                },
                child: Text("SUBMIT"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
