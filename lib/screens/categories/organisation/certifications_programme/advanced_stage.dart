import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/organisation/certifications_programme/applyforcertification_advanced.dart';
import 'package:raynottschool/screens/categories/organisation/certifications_programme/videoclass_advanced.dart';

class AdvancedStage extends StatefulWidget {
  const AdvancedStage({super.key});

  @override
  State<AdvancedStage> createState() => _AdvancedStageState();
}

class _AdvancedStageState extends State<AdvancedStage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white10,
        body: Center(
            child:  Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> VideoclassAdvanced()));
                    },
                    child: buildContainer("VIDEO CLASSES "),),
                  SizedBox(height: 15,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ApplyforcertificationAdvanced()));
                    },
                    child:
                    buildContainer("APPLY FOR CERTIFICATIONS"),
                  ),
                ])
        )
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

