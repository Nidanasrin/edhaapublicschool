import 'package:flutter/material.dart';

class SubjectwiseDetails extends StatefulWidget {
  const SubjectwiseDetails({super.key});

  @override
  State<SubjectwiseDetails> createState() => _SubjectwiseDetailsState();
}

class _SubjectwiseDetailsState extends State<SubjectwiseDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            Text("ALEENA FRANCIS    :  12.0",style: TextStyle(color: Colors.white,fontSize: 16),)
          ],
        ),
      ),
    );
  }
}
