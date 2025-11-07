import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'package:raynottschool/screens/categories/registration_status/app_users/studentwise_report.dart';

class ClasswiseReports extends StatefulWidget {
  final int users;
  final int nonUsers;

  const ClasswiseReports({super.key, required this.users, required this.nonUsers});
  @override
  State<ClasswiseReports> createState() => _ClasswiseReportsState();
}

class _ClasswiseReportsState extends State<ClasswiseReports> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    int total = (widget.users + widget.nonUsers);
    double percentage = total == 0 ? 0 : (widget.users / total) * 100;

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
        Row(
        children: [
        Expanded(
        flex: 4,
            child: Text("Class Name :", style: TextStyle(color: Colors.white, fontSize: 18))),
        SizedBox(width: 10),
        Expanded(
          flex: 5,
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            isExpanded: true,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "Select Class",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
            items: list
                .map((e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e, style: TextStyle(color: Colors.black)),
            ))
                .toList(),
            onChanged: (value){
                selectedValue = value;
            },
          ),
        ),
        ],
            ),
            SizedBox(height: 10,),

            rowField("Reg Students", 0.toString()),
            SizedBox(height: 10,),
            rowField("App Users", 0.toString()),
            SizedBox(height: 10,),
            rowField("Percentage", "0.0%"),
            SizedBox(height: 25,),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if(selectedValue ==null){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select class")));
                  }else {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            StudentwiseReport(selectedClass: selectedValue!,)));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("STUDENT WISE REPORTS", style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: 150,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: widget.users.toDouble(),
                      title: "${((widget.users / (total == 0 ? 1 : total)) * 100).toStringAsFixed(1)}%",
                      color: Colors.green,
                      radius: 70,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      value: widget.nonUsers.toDouble(),
                      title: "${((widget.nonUsers / (total == 0 ? 1 : total)) * 100).toStringAsFixed(1)}%",
                      color: Colors.pink,
                      radius: 70,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                  sectionsSpace: 2,
                  centerSpaceRadius: 0,
                ),
              ),
            ),
            ]),
      )
    );
  }
}

Widget rowField(
   String title,
  String value,
) {
  return Row(
    children: [
      Expanded(
          flex: 4,
          child: Text(title, style: TextStyle(color: Colors.white, fontSize: 18))),
      SizedBox(width: 10),
      Expanded(
        flex: 5,
        child: Text(
          ":  $value ",style: TextStyle(color: Colors.white),
        )
      ),
    ],
  );
}