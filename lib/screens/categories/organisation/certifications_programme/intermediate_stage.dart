import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/organisation/certifications_programme/applyforcertification_intermediate.dart';
import 'package:raynottschool/screens/categories/organisation/certifications_programme/videoclass_intermediate.dart';

class IntermediateStage extends StatefulWidget {
  const IntermediateStage({super.key});

  @override
  State<IntermediateStage> createState() => _IntermediateStageState();
}

class _IntermediateStageState extends State<IntermediateStage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white10,
        body: Center(
            child:  Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> VideoclassIntermediate()));
                    },
                    child: buildContainer("VIDEO CLASSES "),),
                  SizedBox(height: 15,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ApplyforcertificationIntermediate(
                      )));
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
