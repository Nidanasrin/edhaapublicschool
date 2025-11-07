import 'package:flutter/material.dart';

class Studentwise2 extends StatefulWidget {
  const Studentwise2({super.key});

  @override
  State<Studentwise2> createState() => _Studentwise2State();
}

class _Studentwise2State extends State<Studentwise2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            Text("ENGLISH",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
           buildRow("Total Marks", " :  12.0"),
            SizedBox(height: 15,),
            buildRow("Least Marks", " :  12.0"),
            SizedBox(height: 15,),
            buildRow("Average Marks", " :  12.0"),
            SizedBox(height: 15,),
            buildRow("M HAVISHA REDDY Marks", " :  12.0"),
            Divider(thickness: 2,height: 30,)
          ],
        ),
      ),
    );
  }
}
Widget buildRow(String title,String value){
  return Row(
    children: [
      Expanded(flex: 3,
          child: Text(title,style: TextStyle(color: Colors.white,fontSize: 17),)),
      Expanded(flex: 3,
          child: Text(value,style: TextStyle(color: Colors.white,fontSize: 17),))
    ],
  );
}