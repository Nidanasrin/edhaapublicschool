import 'package:flutter/material.dart';

class PromoteStudents2 extends StatefulWidget {
  const PromoteStudents2({super.key});

  @override
  State<PromoteStudents2> createState() => _PromoteStudents2State();
}

class _PromoteStudents2State extends State<PromoteStudents2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child: Text("No Students Available"),
      ),
    );
  }
}
