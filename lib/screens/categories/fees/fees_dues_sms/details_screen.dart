import 'package:flutter/material.dart';
import '../../../../dummydata/datas.dart'; // Make sure this imports the classStudentFees map

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});


  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<Map<String, dynamic>> students = [];

  @override
  void initState() {
    super.initState();
    // Fetch students based on selected class
    students = classStudentFees["NURSERY"] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.blueGrey.shade900),
          border: TableBorder.all(color: Colors.white),
          columns: const [
            DataColumn(
              label: Text(
                "Student Name",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 17),
              ),
            ),
            DataColumn(
              label: Text(
                "Total Amount",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 17),
              ),
            ),
            DataColumn(
              label: Text(
                "Amount Paid",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 17),
              ),
            ),
            DataColumn(
              label: Text(
                "Concession",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 17),
              ),
            ),
            DataColumn(
              label: Text(
                "Due Amount",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 17),
              ),
            ),
          ],
          rows: students.map((student) {
            int totalAmount = student["total"];
            int amountPaid = student["paid"];
            int concession = student["concession"];
            int dueAmount = totalAmount - (amountPaid + concession);

            return DataRow(cells: [
              DataCell(Text(student["name"], style: const TextStyle(color: Colors.white))),
              DataCell(Text(totalAmount.toString(), style: const TextStyle(color: Colors.white))),
              DataCell(Text(amountPaid.toString(), style: const TextStyle(color: Colors.white))),
              DataCell(Text(concession.toString(), style: const TextStyle(color: Colors.white))),
              DataCell(Text(dueAmount.toString(), style: const TextStyle(color: Colors.white))),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
