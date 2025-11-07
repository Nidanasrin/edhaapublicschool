import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/organisation/certifications_programme/applyforcertification_implementation.dart';
import 'package:raynottschool/screens/categories/organisation/certifications_programme/videoclass_implementation.dart';

class ImplementationStage extends StatefulWidget {
  const ImplementationStage({super.key});

  @override
  State<ImplementationStage> createState() => _ImplementationStageState();
}

class _ImplementationStageState extends State<ImplementationStage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white10,
        body: Center(
            child:  Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> VideoclassImplementation()));
                    },
                    child: buildContainer("VIDEO CLASSES "),),
                  SizedBox(height: 15,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ApplyforcertificationImplementation()));
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