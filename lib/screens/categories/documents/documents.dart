import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/documents/aadhaar_apaar/aadhaar_apaar.dart';
import 'package:raynottschool/screens/categories/documents/admission_hallticketinfo/admissionhallticket_info/admission_hallticket_info.dart';
import 'package:raynottschool/screens/categories/documents/dropped_out_list/dropped_out_list.dart';
import 'package:raynottschool/screens/categories/update_guardian_details/update_guardian_details.dart';

import 'other_documents/other_documents.dart';

class Documents extends StatefulWidget {
  const Documents({super.key});

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child:  Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AdmissionHallticketInfo()));
                },
                child: buildContainer("ADMISSION / HALL TICKET INFO"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> OtherDocuments()));
                },
                child:
                buildContainer("OTHER DOCUMENTS"),
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AadhaarApaar()));
                },
                child:
                buildContainer("AADHAAR / APAAR"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateGuardianDetails()));
                },
                child:
                buildContainer("UPDATE GUARDIAN DETAILS"),),
              SizedBox(height: 15,),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DroppedOutList()));
                  },
                  child:
                  buildContainer("DROPPED OUT LIST")),
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
