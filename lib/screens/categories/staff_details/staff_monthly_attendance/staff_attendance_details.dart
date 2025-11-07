import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class StaffAttendanceDetails extends StatefulWidget {
final String staffName;

  const StaffAttendanceDetails({super.key, required this.staffName});
  @override
  State<StaffAttendanceDetails> createState() => _StaffAttendanceDetailsState();
}

class _StaffAttendanceDetailsState extends State<StaffAttendanceDetails> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  List<DateTime> holidays = [
    DateTime(2025, 10, 1),
    DateTime(2025, 10, 2),
    DateTime(2025, 10, 3),
    DateTime(2025, 10, 5),
    DateTime(2025, 10, 7),
  ];
  List<DateTime> absents = [
    DateTime(2025, 10, 13),
  ];

  @override
  Widget build(BuildContext context) {
    int totalDays = DateTime(2025, 10 + 1, 0).day;
    int totalHolidays = holidays.length;
    int totalWorkingDays = totalDays - totalHolidays;
    int totalAbsentDays = absents.length;
    int totalPresentDays = totalWorkingDays - totalAbsentDays;

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        title: Text(widget.staffName.toUpperCase(),
            style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade900,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: focusedDay,
              calendarFormat: CalendarFormat.month,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.indigo.shade200,
                  shape: BoxShape.circle,
                ),
                outsideDaysVisible: false,
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, date, _) {
                  // holiday highlight (purple)
                  if (holidays.any((d) =>
                  d.day == date.day && d.month == date.month)) {
                    return Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text("${date.day}"),
                    );
                  }
                  // absent highlight (red)
                  if (absents.any(
                          (d) => d.day == date.day && d.month == date.month)) {
                    return Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text("${date.day}",
                          style: const TextStyle(color: Colors.white)),
                    );
                  }
                  return null;
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          buildInfoRow("Total Days", "$totalDays"),
          buildInfoRow("Total Holidays", "$totalHolidays"),
          buildInfoRow("Total Working Days", "$totalWorkingDays"),
          buildInfoRow("Total Present Days", "$totalPresentDays"),
          buildInfoRow("Total Absent Days", "$totalAbsentDays"),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Attendance submitted!")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: const BorderSide(color: Colors.white, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              ),
              child: const Text("SUBMIT",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Row(
        children: [
          Expanded(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              )),
          Text(
            ":  $value",
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
