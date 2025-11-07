import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/attendence/face_attendance/setholiday_screen2.dart';

class SetHolidays extends StatefulWidget {
  const SetHolidays({super.key});

  @override
  State<SetHolidays> createState() => _SetHolidaysState();
}

class _SetHolidaysState extends State<SetHolidays> {
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

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    selectedMonth = month[now.month-1];
    selectedYear = now.year.toString();
  }

  String? selectedMonth;
  String? selectedYear;
  List<DateTime> holidayDates = [];
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
 void msgBox(){
   showDialog(context: context, builder: (context)=>
   AlertDialog(
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
     backgroundColor: Colors.white,
     title: Text("Message",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
     content: Text("Please Set Holidays"),
     actions: [
       TextButton(onPressed: (){
         Navigator.pop(context);
         Navigator.push(
             context,
             MaterialPageRoute(
                 builder: (context) =>
                     SetholidayScreen2(month: selectedMonth!, year: int.parse(selectedYear!)
                     )
             )
         );
       }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
     ],
   ));
 }
  void msgBox2(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.white,
          title: Text("Message",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
          content: Text("Holidays Created Successfully"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
          ],
        ));
  }
void deleteHoliday(DateTime date){

  showDialog(
  context: context,
  builder: (context) => AlertDialog(
  title: Text("Holiday Exists"),
  content: Text("Are you sure wants to delete the Holiday?"),
  actions: [
    TextButton(onPressed: (){
      Navigator.pop(context);
    }, child: Text("No",style: TextStyle(color: Colors.indigo.shade900),)),
    TextButton(onPressed: (){
      setState(() {
        holidayDates.removeWhere((d)=>
        d.day == date.day &&
  d.month == date.month &&
  d.year == date.year);
      });
      Navigator.pop(context);
  }, child: Text("Yes",style: TextStyle(color: Colors.indigo.shade900),))
    ]
  ));
  }
  Future<void> pickHolidayDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      bool alreadyHoliday = holidayDates.any((d) =>
      d.day == pickedDate.day &&
          d.month == pickedDate.month &&
          d.year == pickedDate.year
      );
      if (alreadyHoliday) {
        deleteHoliday(pickedDate);
      } else {
setState(() {
  holidayDates.add(pickedDate);
});
msgBox2();
      }
    }
  }

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
                  if (selectedMonth != null || selectedYear !=null) {
                    final selectedDate = "${selectedMonth!} ${selectedYear!}";
msgBox();

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

