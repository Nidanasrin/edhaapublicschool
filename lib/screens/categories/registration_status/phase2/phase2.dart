import 'package:flutter/material.dart';

class Phase2 extends StatefulWidget {
  const Phase2({super.key});

  @override
  State<Phase2> createState() => _Phase2State();
}

class _Phase2State extends State<Phase2> {
  List<String> text = [
    "Fees : Fee Creation/Standardisation/Fee Collections/Fees Receipts/Due Reports",
    "Reviews/Remarks/Achievements/Documents",
    "School Calendar/Gallery/Time Table",
    "Order Placing/Tracking",
    "Leave & PTM Management/ToDoList",
    "Inventory & Expenditure Management",
    "Scan Card Feature",
    "Tech Support : Support Tickets/Whats App Support/Live Support",
    "Product Offerings",
    "Connect Dedicated DCE"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.separated(itemBuilder: (context,index){
              final list = text[index];
              return ListTile(
                  title: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Step ${index+10}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                             Text("PENDING",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        SizedBox(height: 7,),
                        Text(list,style: TextStyle(color: Colors.white,fontSize: 15),)
                      ]
                  )
              );
            }, separatorBuilder: (context,index)=> Divider(thickness: 1,height: 10,), itemCount: text.length),
          )
        ],
      ),
    );
  }
}

