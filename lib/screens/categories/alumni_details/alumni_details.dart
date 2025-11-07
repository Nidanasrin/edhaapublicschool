import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/alumni_details/add_alumni_details.dart';

class AlumniDetails extends StatefulWidget {
  const AlumniDetails({super.key});

  @override
  State<AlumniDetails> createState() => _AlumniDetailsState();
}

class _AlumniDetailsState extends State<AlumniDetails> {
  final List<Map<String,dynamic>> alumniList = [];
  TextEditingController searchController = TextEditingController();

  void alumniDetail()async{
  final result = await Navigator.push(context, MaterialPageRoute(builder: (context)=> AddAlumniDetails()));
  if(result !=null && result is Map<String,dynamic>){
    setState(() {
      alumniList.add(result);
    });
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      floatingActionButton: FloatingActionButton(
backgroundColor: Colors.white,
          foregroundColor: Colors.indigo.shade900,
          shape: CircleBorder(),
          child: IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AddAlumniDetails()));
          }, icon: Icon(Icons.add,size: 30,)),
          onPressed: (){}),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5)
              ),child: TextField(
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              hintText: "Student Name/Company Name",
              hintStyle: TextStyle(color: Colors.grey) ,
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search)),
            ),
            ),
            SizedBox(height: 15,),
            Expanded(child: alumniList.isEmpty ?
            Center(
              child: Text(
                "No Alumni Added Yet",
                style: TextStyle(color: Colors.white),
              ),
            )
                : ListView.separated(itemBuilder: (context,index){
                  final name = alumniList[index]['Student Name'];
return ListTile(
  title: Text(name,style: TextStyle(color: Colors.white),),
);
            }, separatorBuilder: (context,index)=> Divider(height: 0,thickness: 1,color: Colors.white,), itemCount: alumniList.length))
          ],
        ),
      ),
    );
  }
}
