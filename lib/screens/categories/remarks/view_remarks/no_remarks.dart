import 'package:flutter/material.dart';

class NoRemarks extends StatefulWidget {
  const NoRemarks({super.key});

  @override
  State<NoRemarks> createState() => _NoRemarksState();
}

class _NoRemarksState extends State<NoRemarks> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        body: Center(
          child: Text("No Remarks Found",style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w600),),
        )
    );
  }
}