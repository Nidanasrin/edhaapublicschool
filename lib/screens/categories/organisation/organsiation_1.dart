import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/organisation/agreements/agreements_1.dart';
import 'package:raynottschool/screens/categories/organisation/certifications_programme/certifications_programme.dart';
import 'package:raynottschool/screens/categories/organisation/digitalcampus/digitalcampus.dart';
import 'package:raynottschool/screens/categories/organisation/org_details_1.dart';


class OrgansiationDetailsScreen1 extends StatefulWidget {
  const OrgansiationDetailsScreen1({super.key});

  @override
  State<OrgansiationDetailsScreen1> createState() => _OrgansiationDetailsScreen1State();
}

class _OrgansiationDetailsScreen1State extends State<OrgansiationDetailsScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(backgroundColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.power_settings_new,size: 30,color: Colors.white,), onPressed: () async {
          return showDialog(context: context, builder: (context){
            return AlertDialog(backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: Text("Message"),
              content: Text("Do you want to logout?"),
              actions: [
              IconButton(onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
              }, icon: Text("YES"))  ,
                IconButton(onPressed: (){
                  
                }, icon: Text("NO"))
              ],
            );
          }
          );
        },),
      ),
      body: Center(
          child:  Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
              GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> OrganisationDetails1()));
      },
          child: buildContainer("ORGANISATION DETAILS"),),
                SizedBox(height: 15,),
      GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Agreements1()));
          },
          child:
                buildContainer("AGREEMENTS"),
      ),
                SizedBox(height: 15,),
      GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> CertificationsProgramme()));
          },
          child:
                buildContainer("CERTIFICATION PROGRAMME"),),
                SizedBox(height: 15,),
      GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Digitalcampus()));
          },
          child:
                buildContainer("DIGITAL CAMPUS STEP BY STEP PROCESS"),),
                SizedBox(height: 15,),
      GestureDetector(
          onTap: (){
            //Navigator.push(context, MaterialPageRoute(builder: (context)=> Agreements1()));
          },
          child:
                buildContainer("MARK SCHOOL LOCATION")),
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
        BorderRadius.circular(5)),
    child: Text(text,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
  );
}