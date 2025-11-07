import 'package:flutter/material.dart';

class VideoclassIntermediate extends StatefulWidget {
  const VideoclassIntermediate({super.key});

  @override
  State<VideoclassIntermediate> createState() => _VideoclassIntermediateState();
}

class _VideoclassIntermediateState extends State<VideoclassIntermediate> {
  List<String> tiles = [
    "HOW TO CRATE SUBJECTS",
    "HOW TO CREATE EXAMINATION",
    "HOW TO VIEW MARKS IN A GRAPHICAL REPRESENTATION",
    "HOW TO SHARE PROGRESS REPORT OF A PARTICULAR EXAM",
    "HOW TO TAKE PRINTOUT OF PROGRESS REPORT FOR A PARTICULAR EXAM",
    "HOW TO VIEW SUBJECT WISE PERFORMANCE IN A PARTICULAR EXAM OF A PARTICULAR CLASS",
    "HOW TO SEE STUDENT PERFORMANCE IN EACH SUBJECT IN A PARTICULAR EXAMINATION WITH REFERENCE TO OVERALL CLASS PERFORMANCE",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white10,
      body:
      Padding(
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
              child: ListView.separated(padding: EdgeInsets.only(top: 10.0),
                itemCount: tiles.length,
                separatorBuilder: ( context, index) => const Divider(
                  color: Colors.white54,
                  thickness: 0.5,height: 5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final tile = tiles[index];
                  return ListTile(contentPadding: EdgeInsets.zero,onTap: (){
                    if(tile=="Initial Stage"){
                      //  Navigator.push(context, MaterialPageRoute(builder: (context)=> ));
                    }
                    else if(tile=="Implementation Stage"){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> ));
                    }
                    else if(tile=="Intermediate Stage"){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> ));
                    }
                    else if(tile=="Advanced Stage"){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> ));
                    }
                    else if(tile=="Digital Campus"){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> ));
                    }
                  },leading: Text("class ${index+1}",style: TextStyle(color: Colors.white,fontSize: 16),),
                    title: Text(tile,style: TextStyle(color: Colors.white,fontSize: 15),),
                    trailing: Text("PENDING",style: TextStyle(color: Colors.red,fontSize: 15),),
                  );
                },),
            ),

          ],
        ),
      ),
    );
  }
}

