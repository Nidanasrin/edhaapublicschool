import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/fees/account_department/account_department.dart';
import 'package:raynottschool/screens/categories/fees/create_fees_type/create_fees_type.dart';
import 'package:raynottschool/screens/categories/fees/fees_collection/fees_collection.dart';
import 'package:raynottschool/screens/categories/fees/fees_concession/fees_concession.dart';
import 'package:raynottschool/screens/categories/fees/fees_dues_sms/fees_dues_sms.dart';
import 'package:raynottschool/screens/categories/fees/fees_standardisation/fees_standardisation.dart';
import 'package:raynottschool/screens/categories/fees/total_fees_report/total_fees_report.dart';

class Fees extends StatefulWidget {
  const Fees({super.key});

  @override
  State<Fees> createState() => _FeesState();
}

class _FeesState extends State<Fees> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child:  Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateFeesType()));
                },
                child: buildContainer("CREATE FEES TYPE"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> FeesStandardisation()));
                },
                child:
                buildContainer("FEES STANDARDISATION"),
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> FeesCollection()));
                },
                child:
                buildContainer("FEES COLLECTION"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> FeesConcession()));
                },
                child:
                buildContainer("FEES CONCESSION"),),
              SizedBox(height: 15,),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> TotalFeesReport()));
                  },
                  child:
                  buildContainer("TOTAL FEES REPORT")),
              SizedBox(height: 15,),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> FeesDuesSms()));
                  },
                  child:
                  buildContainer("FEES DUES SMS")),
              SizedBox(height: 15,),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AccountDepartment()));
                  },
                  child:
                  buildContainer("ACCOUNT DEPARTMENT")),
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