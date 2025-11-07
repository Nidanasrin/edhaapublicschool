import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        children: [
          SizedBox(height: 50,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Text("Date",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold)),
            Text("Receipt No",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold)),
            Text("Amount",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),)
            ],
          ),
          Divider(thickness: 2,height: 30,),

          buildRow("08/10/2025", "23", "4000"),
          Divider(thickness: 0.5,height: 15,),
          buildRow("16/07/2025", "26", "7000"),
          Divider(thickness: 0.5,height: 15,),
          buildRow("07/10/2025", "30", "8000"),
          Divider(thickness: 0.5,height: 15,),

        ],
      ),
    );
  }
}
Widget buildRow(String date,String num,String amount){
  return Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text(date,style: TextStyle(color: Colors.white,fontSize: 16),),
      Text(num.toString(),style: TextStyle(color: Colors.white,fontSize: 16),),
     Text(amount.toString(),style: TextStyle(color: Colors.white,fontSize: 16),)
    ],
  );
}