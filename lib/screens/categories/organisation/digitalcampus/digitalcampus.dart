import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/organisation/digitalcampus/phase1.dart';
import 'package:raynottschool/screens/categories/organisation/digitalcampus/phase2.dart';

class Digitalcampus extends StatefulWidget {
  const Digitalcampus({super.key});

  @override
  State<Digitalcampus> createState() => _DigitalcampusState();
}

class _DigitalcampusState extends State<Digitalcampus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body:  Center(
        child:  Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Phase1()));
                },
                child: buildContainer("PHASE 1"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Phase2()));
                },
                child:
                buildContainer("PHASE 2"),
              ),
            ]
        ),
      ),
    );
  }
}
Widget buildContainer(String text){
  return Container(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.white,width: 2),
        borderRadius:
        BorderRadius.circular(10)),
    child: Text(text,style: TextStyle(color: Colors.white,fontSize: 15),),
  );
}
