import 'package:flutter/material.dart';

class Phase2 extends StatefulWidget {
  const Phase2({super.key});

  @override
  State<Phase2> createState() => _Phase2State();
}

class _Phase2State extends State<Phase2> {
  List<String> list = [
    "Fees : Fee Creation/Standardisation/Fee Collections/Fees receipts/Due Reports",
    "Reviews/Remarks/Achievements/Documents",
    "School Calendar/Gallery/Time Table",
    "Order Placing/Tracking",
    "Leave & PTM Management/Todo List",
    "Inventory & Expenditure Management",
    "Scan Card Feature",
    "Tech Support : Support Tickets/Whatsapp Support/Live Support",
    "Product Offerings",
    "Connect Dedicated DCE"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white10,
      body: ListView.separated(padding: EdgeInsets.only(top: 10.0),
        itemCount: list.length,
        separatorBuilder: ( context, index) => const Divider(
          color: Colors.white54,
          thickness: 0.5,height: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          final tile = list[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Step ${index +1 }",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                    Text("PENDING",style: TextStyle(
                          fontSize: 16,fontWeight: FontWeight.bold,color: Colors.red
                      ),
          )
                  ],
                ),
                SizedBox(height: 5,),
                Text(tile,style: TextStyle(fontSize: 16,color: Colors.white),)
              ],
            ),
          );
        },),
    );
  }
}
