import 'package:flutter/material.dart';

class NoReview extends StatelessWidget {
  const NoReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child: Text("No Reviews Found",style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w600),),
      )
    );
  }
}
