import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ManualattendanceDetails extends StatefulWidget {
  final String studentName;
  final String date; // e.g., "October 2025"

  const ManualattendanceDetails({
    super.key,
    required this.studentName,
    required this.date,
  });

  @override
  State<ManualattendanceDetails> createState() =>
      _ManualattendanceDetailsState();
}

class _ManualattendanceDetailsState extends State<ManualattendanceDetails> {
  late DateTime focusedDay;
  late int month;
  late int year;

  @override
  void initState() {
    super.initState();
    _parseDate(widget.date);
  }

  // Parse "October 2025" into month and year
  void _parseDate(String date) {
    final parts = date.split(" "); // ["October", "2025"]
    final monthName = parts[0];
    year = int.parse(parts[1]);
    month = _monthStringToNumber(monthName);
    focusedDay = DateTime(year, month, 1);
  }

  int _monthStringToNumber(String month) {
    switch (month.toLowerCase()) {
      case "january":
        return 1;
      case "february":
        return 2;
      case "march":
        return 3;
      case "april":
        return 4;
      case "may":
        return 5;
      case "june":
        return 6;
      case "july":
        return 7;
      case "august":
        return 8;
      case "september":
        return 9;
      case "october":
        return 10;
      case "november":
        return 11;
      case "december":
        return 12;
      default:
        return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalDays = DateTime(year, month + 1, 0).day;
    final totalHolidays = 3; // Example
    final totalWorkingDays = totalDays - totalHolidays;
    final totalPresentDays = 27;
    final totalAbsentDays = totalWorkingDays - totalPresentDays;

    final absentDates = [
      DateTime(year, month, 1),
      DateTime(year, month, 2),
      DateTime(year, month, 7),
    ];

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        foregroundColor: Colors.white,
        title: Text(widget.studentName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: TableCalendar(
                firstDay: DateTime(year, month, 1),
                lastDay: DateTime(year, month, totalDays),
                focusedDay: focusedDay,
                calendarFormat: CalendarFormat.month,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 17),
                  leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black,),
                  rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
                ),
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  todayDecoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                  defaultDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (absentDates.any((d) =>
                    d.day == date.day &&
                        d.month == date.month &&
                        d.year == date.year)) {
                      return Container(
                        margin: EdgeInsets.all(6),
                        decoration:
                        BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: Text(date.day.toString(),style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      );
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildSummaryRow("Total Days", totalDays),
            _buildSummaryRow("Total Holidays", totalHolidays),
            _buildSummaryRow("Total Working Days", totalWorkingDays),
            _buildSummaryRow("Total Present Days", totalPresentDays),
            _buildSummaryRow("Total Absent Days", totalAbsentDays),
            const SizedBox(height: 30),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
                style: TextStyle(color: Colors.white, fontSize: 17)),
          ),
          Text(": $value", style: TextStyle(color: Colors.white, fontSize: 17)),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Image.asset("assets/images/app_sms.png", height: 30),
        ),
        const SizedBox(width: 40),
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Image.asset("assets/images/phone.png", height: 40),
        ),
        const SizedBox(width: 40),
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Image.asset("assets/images/bell (1).png", height: 30),
        ),
      ],
    );
  }
}
