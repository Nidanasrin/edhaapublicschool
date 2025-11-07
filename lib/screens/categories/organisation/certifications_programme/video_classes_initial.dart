import 'package:flutter/material.dart';

class VideoClasses extends StatefulWidget {
  const VideoClasses({super.key});

  @override
  State<VideoClasses> createState() => _VideoClassesState();
}

class _VideoClassesState extends State<VideoClasses> {
  List<String> tiles = [
    "HOW TO DOWNLOAD STUDENT UNIQUE CARD APP FROM GOOGLE PLAY STORE?",
    "HOW TO CREATE CLASSES",
    "HOW TO REGISTER A STAFF",
    "HOW TO MAP CLASS TEACHERS",
    "HOW TO SEND SMS TO TOTAL ORGANISATION",
    "HOW TO SEND SMS TO MULTIPLE CLASSES",
    "HOW TO SEND SMS TO SINGLE CLASS",
    "HOW TO SEND SMS TO MULTIPLE STUDENTS",
    "HOW TO SEND SMS TO SINGLE STUDENTS",
    "HOW TO SEND SMS IN REGIONAL LANGUAGES"
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
