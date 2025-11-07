import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/achievements/add_achievements/add_achievements.dart';
import 'package:raynottschool/screens/categories/achievements/view_achievements/view_achievements.dart';

import '../../../dummydata/datas.dart';

class Achievements extends StatefulWidget {
  const Achievements({super.key});

  @override
  State<Achievements> createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  "Class Name",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),),
              Expanded(
                flex: 5,
                child: DropdownButtonFormField<String>(
                  value: selectedValue,
                  isExpanded: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  items: list
                      .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e, style: TextStyle(color: Colors.black)),
                  ))
                      .toList(),
                  onChanged: (value){
                    selectedValue = value;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if(selectedValue ==null ){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select class")));
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewAchievements(selectedStudent: selectedValue!)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade900,
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("VIEW ACHIEVEMENTS", style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 20,) ,
                ElevatedButton(
                  onPressed: () {
                    if(selectedValue ==null ){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select class")));
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AddAchievements(selectedStudent: selectedValue!, selectedClass: selectedValue!,)));

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade900,
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("ADD ACHIEVEMENTS", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

