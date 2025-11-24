import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SetholidayScreen2 extends StatefulWidget {
  final String month;
  final int year;

  const SetholidayScreen2({super.key, required this.month, required this.year});

  @override
  State<SetholidayScreen2> createState() => _SetholidayScreen2State();
}

class _SetholidayScreen2State extends State<SetholidayScreen2> {
  late DateTime focusedDay;
  late int totalDays;
  int totalHolidays = 0;
  int totalWorkingDays = 0;
  bool isLoading = false;

  final Set<DateTime> selectedHolidays = {};
  final Map<String, int> monthMap = {
    "January": 1,
    "February": 2,
    "March": 3,
    "April": 4,
    "May": 5,
    "June": 6,
    "July": 7,
    "August": 8,
    "September": 9,
    "October": 10,
    "November": 11,
    "December": 12,
  };

  @override
  void initState() {
    super.initState();
    int monthNumber = monthMap[widget.month]!; // convert month name to number
    focusedDay = DateTime(widget.year, monthNumber, 1);
    totalDays = DateTime(widget.year, monthNumber + 1, 0).day;
    totalHolidays = 0;
    totalWorkingDays = totalDays;
    loadHolidays();
  }

  void toggleHoliday(DateTime day) {
    setState(() {
      DateTime normalized = DateTime(day.year, day.month, day.day);
      if (selectedHolidays.contains(normalized)) {
        selectedHolidays.remove(normalized);
      } else {
        selectedHolidays.add(normalized);
      }
      totalHolidays = selectedHolidays.length;
      totalWorkingDays = totalDays - totalHolidays;
    });
  }

  Future<void> loadHolidays()async{
    try{
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('attendance')
          .doc('face_attendance')
          .collection('set_Holiday')
          .doc('${widget.month}/${widget.year}')
          .get();
      if(snap.exists){
        List<dynamic> savedDates = snap['Holiday Dates'];
        for(var d in savedDates){
          List<String> parts = d.split('-');
          int day = int.parse(parts[0]);
          int month = int.parse(parts[1]);
          int year = int.parse(parts[2]);
          selectedHolidays.add(DateTime(year,month,day));
        }
        setState(() {
          totalHolidays = selectedHolidays.length;
          totalWorkingDays = totalDays - totalHolidays;
        });
      }
    }catch(e){
      print('Error loading holidays : $e');
    }
  }

  Future<void> uploadToFirebase() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<String> holidayDates = selectedHolidays
          .map((d) => '${d.day}-${d.month}-${d.year}')
          .toList();
      await FirebaseFirestore.instance
          .collection('attendance')
          .doc('face_attendance')
          .collection('set_Holiday')
          .doc('${widget.month}_${widget.year}')
          .set({
            'Month': widget.month,
            'Year': widget.year,
            'Total Days': totalDays,
            'Total Holidays': totalHolidays,
            'Total Working Days': totalWorkingDays,
        'Holiday Dates' : holidayDates,
        'CreatedAt' : DateTime.now()
          });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Holidays saved successfully!')));
    } catch (e) {
      print('Error submitting holiday : $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error : $e')));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: TableCalendar(
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),
              focusedDay: focusedDay,
              calendarFormat: CalendarFormat.month,
              headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
                titleCentered: true,
                formatButtonVisible: false,
              ),
              selectedDayPredicate: (day) {
                return selectedHolidays.contains(
                  DateTime(day.year, day.month, day.day),
                );
              },
              onDaySelected: (selectedDay, focusedDay) {
                toggleHoliday(selectedDay);
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  DateTime normalized = DateTime(day.year, day.month, day.day);
                  if (selectedHolidays.contains(normalized)) {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        day.day.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Days",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      ": $totalDays",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Holidays",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      ": $totalHolidays",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Working Days",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      ": $totalWorkingDays",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: BorderSide(width: 2, color: Colors.white),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
              ),
              onPressed: isLoading ? null : uploadToFirebase,
              child: isLoading ? CircularProgressIndicator(color: Colors.white,)
              : Text("SUBMIT"),
            ),
          ),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }
}
