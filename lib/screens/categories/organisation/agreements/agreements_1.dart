import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/organisation/agreements/aiface_agreement.dart';
import 'package:raynottschool/screens/categories/organisation/agreements/dataconfidentiality_agreement.dart';
import 'package:raynottschool/screens/categories/organisation/agreements/threesales_agreement.dart';
import 'cashpolicy_agreement.dart';

class Agreements1 extends StatefulWidget {
  const Agreements1({super.key});

  @override
  State<Agreements1> createState() => _Agreements1State();
}

class _Agreements1State extends State<Agreements1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body:  Center(
        child:  Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> noCashpolicyAgreement()));
                },
                child: buildContainer("NO CASH POLICY AGREEMENT"),),
              SizedBox(height: 15,),
      GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> DataconfidentialityAgreement()));
          },
          child:
              buildContainer("DATA CONFIDENTIALITY AGREEMENT"),
      ),
              SizedBox(height: 15,),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ThreesalesAgreement()));
                  },
                  child:
              buildContainer("THREE YEARS SALES AGREEMENT"),),
              SizedBox(height: 15,),
      GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AifaceAgreement()));
          },
          child:
              buildContainer("AI FACE AGREEMENT"),),
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
