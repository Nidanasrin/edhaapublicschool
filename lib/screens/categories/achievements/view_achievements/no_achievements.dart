import 'package:flutter/material.dart';

class NoAchievements extends StatefulWidget {
  const NoAchievements({super.key});

  @override
  State<NoAchievements> createState() => _NoAchievementsState();
}

class _NoAchievementsState extends State<NoAchievements> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        body: Center(
          child: Text("No Achievemnts Found",style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w600),),
        )
    );
  }
}
