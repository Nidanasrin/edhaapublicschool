import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/analytics/subject_wise/subjectwise_details.dart';

class SubjectWise3 extends StatefulWidget {
  const SubjectWise3({super.key});

  @override
  State<SubjectWise3> createState() => _SubjectWise3State();
}

class _SubjectWise3State extends State<SubjectWise3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
       backgroundColor: Colors.blueGrey.shade900,
       automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 2,
                  child:
                Text("Total Marks         :   12.0",style: TextStyle(color: Colors.white,fontSize: 16),),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SubjectwiseDetails()));

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("DETAILS", style: TextStyle(color: Colors.white)),
                ),
            ]
            ),
            SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                    Expanded(flex: 2,
                      child:
                      Text("Least Marks        :   12.0",style: TextStyle(color: Colors.white,fontSize: 16),),
                    ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SubjectwiseDetails()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("DETAILS", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            Divider(thickness: 1,height: 30,),
            Row(
              children: [
                Expanded(flex: 2,
                  child:
                  Text("Least Marks",style: TextStyle(color: Colors.white,fontSize: 16),),
                ),
                Expanded(flex: 1,
                    child: Text(":  12.0",style: TextStyle(color: Colors.white,fontSize: 16),)),
              ],
            ),
            Divider(thickness: 1,height: 30,),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SubjectwiseDetails()));

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("VIEW TOTAL MARKS DETAILS", style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("VIEW ABSENTEES", style: TextStyle(color: Colors.white)),
              ),
            ),
        ]
      )
      )
    );
  }
}
