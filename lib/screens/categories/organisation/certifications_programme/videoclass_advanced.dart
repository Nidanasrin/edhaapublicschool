import 'package:flutter/material.dart';

class VideoclassAdvanced extends StatefulWidget {
  const VideoclassAdvanced({super.key});

  @override
  State<VideoclassAdvanced> createState() => _VideoclassAdvancedState();
}

class _VideoclassAdvancedState extends State<VideoclassAdvanced> {
  List<String> tiles = [
    "HOW TO UPDATE EVENTS IN SCHOOL CALENDAR",
    "HOW TO CREATE ALBUM NAME",
    "HOW TO UPLOAD PHOTOS IN ALBUM",
    "HOW TO VIEW PHOTOS IN ALBUM",
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
