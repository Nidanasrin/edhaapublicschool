import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/fees/fees_standardisation/create_classwise.dart';
import 'package:raynottschool/screens/categories/fees/fees_standardisation/create_organization_wise.dart';
import 'package:raynottschool/screens/categories/fees/fees_standardisation/create_studentwise.dart';
import 'package:raynottschool/screens/categories/fees/fees_standardisation/create_studentwise_details.dart';
import 'package:raynottschool/screens/categories/fees/fees_standardisation/delete_classwise.dart';
import 'package:raynottschool/screens/categories/fees/fees_standardisation/delete_organization_wise.dart';
import 'package:raynottschool/screens/categories/fees/fees_standardisation/delete_studentwise.dart';

class FeesStandardisation extends StatefulWidget {
  const FeesStandardisation({super.key});

  @override
  State<FeesStandardisation> createState() => _FeesStandardisationState();
}

class _FeesStandardisationState extends State<FeesStandardisation> {

  void deleteDialog(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
          ),
          content: Column(mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.indigo.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 2, color: Colors.indigo.shade900),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DeleteOrganizationWise()));
                },
                child: const Text(
                  'ORGANIZATION WISE',style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ), SizedBox(height: 15,),ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.indigo.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 2, color: Colors.indigo.shade900),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DeleteClasswise()));

                },
                child: const Text(
                  'CLASS WISE',style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ), SizedBox(height: 15,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.indigo.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 2, color: Colors.indigo.shade900),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DeleteStudentwise()));

                },
                child: const Text(
                  'STUDENTS WISE',style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ));
  }
  void createdialog(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
          ),
          content: Column(mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.indigo.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 2, color: Colors.indigo.shade900),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateOrganizationWise()));
                },
                child: const Text(
                  'ORGANIZATION WISE',style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ), SizedBox(height: 15,),ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.indigo.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 2, color: Colors.indigo.shade900),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Classwise()));

                },
                child: const Text(
                  'CLASS WISE',style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ), SizedBox(height: 15,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.indigo.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 2, color: Colors.indigo.shade900),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateStudentwise()));

                },
                child: const Text(
                  'STUDENTS WISE',style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child:  Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                 createdialog();
                },
                child: buildContainer("CREATE FEES STANDARDISATION"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
deleteDialog();
                },
                child:
                buildContainer("DELETE FEES STANDARDISATION"),
              )
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

