import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/registration_status/app_users/classwise_reports.dart';

class AppUsers extends StatelessWidget {
final int users;
final int nonUsers;

  const AppUsers({super.key, required this.users, required this.nonUsers});

  @override
  Widget build(BuildContext context) {
    // ✅ Fix: access both using widget.users / widget.nonUsers
    int total = users + nonUsers;
    double percentage = total == 0 ? 0 : (users / total) * 100;

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                const Text("Reg Students", style: TextStyle(color: Colors.white, fontSize: 15)),
                const SizedBox(width: 10),
                Text(":  $total", style: const TextStyle(color: Colors.white, fontSize: 15)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("App Users", style: TextStyle(color: Colors.white, fontSize: 15)),
                const SizedBox(width: 10),
                Text(":  ${users}", style: const TextStyle(color: Colors.white, fontSize: 15)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Percentage", style: TextStyle(color: Colors.white, fontSize: 15)),
                const SizedBox(width: 10),
                Text(":  ${percentage.toStringAsFixed(1)}%", style: const TextStyle(color: Colors.white, fontSize: 15)),
              ],
            ),
            SizedBox(height: 20,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade900,
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white,width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ClasswiseReports(users: users,nonUsers: nonUsers,)));
                }, child: Text("CLASS WISE REPORT")),
             SizedBox(height: 30),

            // ✅ Circle chart
            SizedBox(
              height: 150,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: users.toDouble(),
                      title: "${((users / (total == 0 ? 1 : total)) * 100).toStringAsFixed(1)}%",
                      color: Colors.green,
                      radius: 70,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      value: nonUsers.toDouble(),
                      title: "${((nonUsers / (total == 0 ? 1 : total)) * 100).toStringAsFixed(1)}%",
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

            const SizedBox(height: 20),

            // ✅ Chart legend
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                _LegendItem(color: Colors.green, label: 'App Users'),
                SizedBox(width: 20),
                _LegendItem(color: Colors.pink, label: 'Non Users'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Legend widget for cleaner look
class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
