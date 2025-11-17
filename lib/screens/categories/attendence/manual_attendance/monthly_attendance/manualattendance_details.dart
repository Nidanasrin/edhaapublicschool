import 'package:cloud_firestore/cloud_firestore.dart';
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

  List<DateTime> leaveDates = [];
  bool showSubmitButton = false;

  @override
  void initState() {
    super.initState();
    _parseDate(widget.date);
  }

  void _parseDate(String date) {
    final parts = date.split(" ");
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

  bool isUploading = false;

  void _submitAttendance() async {
    final formattedDates = leaveDates
        .map((d) => "${d.year}-${d.month}-${d.day}")
        .toList();

    await FirebaseFirestore.instance
        .collection('attendance')
        .doc("manual_attendance")
        .collection('monthly_attendance')
        .doc(widget.studentName + "_${widget.date}")
        .set({
      "studentName": widget.studentName,
      "month": widget.date,
      "leaveDates": formattedDates,
      "submittedAt": DateTime.now(),
    });

    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text("Success", style: TextStyle(fontSize: 20),),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)),
            content:
            Text("Monthly attendance submitted successfully!",
              style: TextStyle(fontSize: 15),),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              )
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalDays = DateTime(year, month + 1, 0).day;
    final totalHolidays = 3;
    final totalWorkingDays = totalDays - totalHolidays;
    final totalPresentDays = totalWorkingDays - leaveDates.length;
    final totalAbsentDays = leaveDates.length;

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
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                  leftChevronIcon:
                  Icon(Icons.chevron_left, color: Colors.black),
                  rightChevronIcon:
                  Icon(Icons.chevron_right, color: Colors.black),
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, date, _) {
                    bool isLeave = leaveDates.any((d) =>
                    d.day == date.day &&
                        d.month == date.month &&
                        d.year == date.year);

                    bool isHoliday = date.weekday == DateTime.sunday;

                    bool isToday = date.day == DateTime
                        .now()
                        .day &&
                        date.month == DateTime
                            .now()
                            .month &&
                        date.year == DateTime
                            .now()
                            .year;

                    if (isToday) {
                      return _buildCircle(date.day, Colors.blue);
                    }

                    if (isHoliday) {
                      return _buildCircle(date.day, Colors.redAccent);
                    }

                    if (isLeave) {
                      return _buildCircle(date.day, Colors.red);
                    }

                    return Center(
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                ),
                selectedDayPredicate: (day) =>
                    leaveDates.any((d) =>
                    d.day == day.day &&
                        d.month == day.month &&
                        d.year == day.year),
                onDaySelected: (selectedDay, _) {
                  if (selectedDay.weekday == DateTime.sunday) return;
                  if (selectedDay.isAfter(DateTime.now())) return;

                  setState(() {
                    bool alreadyLeave = leaveDates.any((d) =>
                    d.day == selectedDay.day &&
                        d.month == selectedDay.month);

                    if (alreadyLeave) {
                      leaveDates.removeWhere(
                              (d) => d.day == selectedDay.day);
                    } else {
                      leaveDates.add(selectedDay);
                    }

                    showSubmitButton = leaveDates.isNotEmpty;
                  });
                },
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
            if (showSubmitButton)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    padding:
                    EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                  ),
                  onPressed: _submitAttendance,
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
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
          Text(": $value",
              style: TextStyle(color: Colors.white, fontSize: 17)),
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


Widget _buildCircle(int day, Color color) {
  return Container(
    margin: EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
    alignment: Alignment.center,
    child: Text(
      day.toString(),
      style:
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}
