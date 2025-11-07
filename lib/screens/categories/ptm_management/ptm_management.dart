import 'package:flutter/material.dart';

class PtmManagement extends StatefulWidget {
  const PtmManagement({super.key});

  @override
  State<PtmManagement> createState() => _PtmManagementState();
}

class _PtmManagementState extends State<PtmManagement> {
  void msgBox(){
    showDialog(context: context, builder: (context)=> AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      backgroundColor: Colors.white,
      title: Text("Message"),
      content: Text("No PTM Requests Found"),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900,fontWeight: FontWeight.bold),))
      ],
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        body: Center(
            child: GestureDetector(
              onTap: ()=> msgBox(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius:
                    BorderRadius.circular(10)),
                child: Text("PTM Requests", style: TextStyle(color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),),
              ),
            )
        ));
  }
}