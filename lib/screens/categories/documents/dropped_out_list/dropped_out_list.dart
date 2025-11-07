import 'package:flutter/material.dart';

class DroppedOutList extends StatefulWidget {
  const DroppedOutList({super.key});

  @override
  State<DroppedOutList> createState() => _DroppedOutListState();
}

class _DroppedOutListState extends State<DroppedOutList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        children: [
          SizedBox(height: 30,),
          Padding(padding: EdgeInsets.all(10),child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Student Name",style: TextStyle(color: Colors.white,fontSize: 16),),
              Text("Class Name",style: TextStyle(color: Colors.white,fontSize: 16),),
            ],
          ),
          ),
          Divider(height: 20,thickness: 1,color: Colors.white,)
        ],
      ),
    );
  }
}
