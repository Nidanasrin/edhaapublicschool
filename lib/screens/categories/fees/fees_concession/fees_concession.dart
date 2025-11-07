import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/fees/fees_concession/apply_feesconcession.dart';
import 'package:raynottschool/screens/categories/fees/fees_concession/delete_concession.dart';

class FeesConcession extends StatefulWidget {
  const FeesConcession({super.key});

  @override
  State<FeesConcession> createState() => _FeesConcessionState();
}

class _FeesConcessionState extends State<FeesConcession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child:  Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ApplyFeesconcession()));
                },
                child: buildContainer("APPLY CONCESSION"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DeleteConcession()));
                },
                child:
                buildContainer("DELETE CONCESSION"),
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
    child: Text(text,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
  );
}