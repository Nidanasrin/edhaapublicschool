import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/organisation/certifications_programme/advanced_stage.dart';
import 'package:raynottschool/screens/categories/organisation/certifications_programme/implementation_stage.dart';
import 'package:raynottschool/screens/categories/organisation/certifications_programme/initial_stage.dart';
import 'package:raynottschool/screens/categories/organisation/certifications_programme/intermediate_stage.dart';

class CertificationsProgramme extends StatefulWidget {
  const CertificationsProgramme({super.key});

  @override
  State<CertificationsProgramme> createState() => _CertificationsProgrammeState();
}

class _CertificationsProgrammeState extends State<CertificationsProgramme> {
  List<String> tiles = [
    "Initial Stage",
    "Implementation Stage",
    "Intermediate Stage",
    "Advanced Stage",
    "Digital Campus"
  ];
  void messagebox(){
     showDialog(context: context, builder: (context)=>
     AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),backgroundColor: Colors.white,
       title: Text("Message"),
       content: Text("No Information Available",style: TextStyle(fontSize: 15),),
       actions: [
         TextButton(onPressed: (){
           Navigator.pop(context);
         }, child: Text("Ok",style: TextStyle(color: Colors.blue.shade900,fontSize: 16),))
       ],
     ));
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white10,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0,),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Staff Name/Staff Code",
                  hintStyle: TextStyle(fontSize: 17,color: Colors.grey.shade600)
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(padding: EdgeInsets.zero,
                itemCount: tiles.length,
               separatorBuilder: ( context, index) => const Divider(
    color: Colors.white54,
    thickness: 0.5,height: 0,
    ),
     itemBuilder: (BuildContext context, int index) {
                final tile = tiles[index];
                return ListTile(contentPadding: EdgeInsets.zero,onTap: (){
                  if(tile=="Initial Stage"){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> InitialStage()));
                  }
                  else if(tile=="Implementation Stage"){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ImplementationStage()));
                  }
                  else if(tile=="Intermediate Stage"){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> IntermediateStage()));
                  }
                  else if(tile=="Advanced Stage"){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AdvancedStage()));
                  }
                  else if(tile=="Digital Campus"){
                   messagebox();
                  }
                },
                    title: Text(tile,style: TextStyle(color: Colors.white),));
              },),
            ),

          ],
        ),
      ),
    );
  }
}
