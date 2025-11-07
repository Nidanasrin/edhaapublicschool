import 'package:flutter/material.dart';

class StatusDetails extends StatefulWidget {

final String status;
final String date;
final String description;
  const StatusDetails({super.key, required this.status, required this.date, required this.description});
  @override
  State<StatusDetails> createState() => _StatusDetailsState();
}

class _StatusDetailsState extends State<StatusDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            infoRow("Raised by", "307255"),
            infoRow("Contact No", "8938393000"),
            infoRow("Date", widget.date),
            infoRow("Status", widget.status),
             SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    flex: 2,child: Text("Ticket Description",style: TextStyle(color: Colors.white,fontSize: 16),)),
                Expanded(
                  flex: 3,
                    child: Text(":  ${widget.description}",style: TextStyle(color: Colors.white,fontSize: 16),))
              ],
            ),

          ]
        ),
      ),
    );
  }
}
Widget infoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(label,
              style: const TextStyle(color: Colors.white, fontSize: 16)),
        ),
        Expanded(
          flex: 3,
          child: Text(": $value",
              style: const TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ],
    ),
  );
}
