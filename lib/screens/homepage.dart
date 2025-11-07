import 'package:flutter/material.dart';
import 'package:raynottschool/screens/screen2.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text("Welcome!",style: TextStyle(fontSize: 17),),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.calendar_month))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 16.0,top: 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("EDHAA PUBLIC SCHOOL",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900)),
          const SizedBox(height: 20),

          /// Attendance Section
          Text("Attendance", style: TextStyle(fontSize: 17)),
          const SizedBox(height: 8),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.2,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildStatCard("Students Present", "100%", "200/200", Icons.people, Colors.green),
              _buildStatCard("Staff Present", "100%", "20/20", Icons.person, Colors.green),
            ],
          ),

          const SizedBox(height: 8),

          /// Fees Section
          Text("Fees", style: TextStyle(fontSize: 17)),
          const SizedBox(height: 8),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            crossAxisSpacing: 12,
            childAspectRatio: 1.2,
            mainAxisSpacing: 12,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildStatCard("Total Collected", "₹1,20,000", "", Icons.payments, Colors.blue),
              _buildStatCard("No. of Students", "200", "", Icons.school, Colors.orange),
            ],
          ),
          Card(color: Colors.white,
            //padding: EdgeInsets.symmetric(horizontal: 50,vertical: 6),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Expenses",style: TextStyle(fontSize: 18),),
                  SizedBox(height: 4,),
                  Text("₹40,000",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 16),)
                ],
              ),
            ),
          ),
          //_buildStatCard("Expenses", "₹40,000", "", Icons.money_off, Colors.red),

          const SizedBox(height: 24),

          /// Menu Button
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> DashboardScreen()));
              },
              child: const Text("Menu", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
        ]),
      ),
    );
  }
}
Widget _buildStatCard(String title, String value, String subtitle, IconData icon, Color color) {
  return Card(color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontSize: 17, )),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: color)),
          SizedBox(height: 2,),
          if (subtitle.isNotEmpty)
            Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
        ],
      ),
    ),
  );
}
