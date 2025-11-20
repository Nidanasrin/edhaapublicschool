import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SetHoliday2 extends StatefulWidget {
  final String month;
  final int year;

  const SetHoliday2({super.key, required this.month, required this.year});

  @override
  State<SetHoliday2> createState() => _SetHoliday2State();
}

class _SetHoliday2State extends State<SetHoliday2> {
  late DateTime focusedDay;
  late int totalDays;
  int totalHolidays = 0;
  int totalWorkingDays = 0;

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
                defaultBuilder: (context, date, _) {
                  bool isSelected = selectedHolidays.contains(
                    DateTime(date.year, date.month, date.day),
                  );
                  bool isToday =
                      date.day == DateTime.now().day &&
                      date.month == DateTime.now().month &&
                      date.year == DateTime.now().year;

                  if (isToday) {
                    return _buildCircle(date.day, Colors.blue);
                  }

                  if (isSelected) {
                    return _buildCircle(date.day, Colors.redAccent);
                  }

                  return Center(
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  );
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
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Holidays saved!")),
                );
              },
              child: const Text("SUBMIT"),
            ),
          ),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }
}

Widget _buildCircle(int day, Color color) {
  return Container(
    margin: const EdgeInsets.all(6),
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    alignment: Alignment.center,
    child: Text("$day", style: const TextStyle(color: Colors.white)),
  );
}
