import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'package:raynottschool/screens/categories/staff_details/staff_details/staffdetails_edit.dart';

class Staffdetailscreen extends StatefulWidget {
final int staffIndex;

  const Staffdetailscreen({super.key, required this.staffIndex});
  @override
  State<Staffdetailscreen> createState() => _StaffdetailscreenState();
}

class _StaffdetailscreenState extends State<Staffdetailscreen> {
  void confirmDelete(){
    showDialog(context: context, builder: (context)=>
AlertDialog(
  title: Text("Delete Staff?"),
  content: Text("Are you sure you want to delete this member?"),
  actions: [
    TextButton(onPressed: (){
      Navigator.pop(context);
    }, child: Text("Cancel",style: TextStyle(color: Colors.indigo.shade900),)),
    TextButton(onPressed: (){
      setState(() {
        staffNames.removeAt(widget.staffIndex);
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Staff deleted successfully")),
      );
    }, child: Text("Delete",style: TextStyle(color: Colors.indigo.shade900),))
  ],
)
    );
  }
  @override
  Widget build(BuildContext context) {
    final staffName = staffNames[widget.staffIndex];

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            buildRow("Staff ID", " :  3073215"),
            SizedBox(height: 15,),
            buildRow("Staff Name", " :  LAKSHMI"),
            SizedBox(height: 15,),
            buildRow("Father Name", " :  ASHOK NAIR"),
            SizedBox(height: 15,),
            buildRow("Designation", " :  TEACHER"),
            SizedBox(height: 15,),
            buildRow("Contact No", " :  9752194076"),
            SizedBox(height: 15,),
            buildRow("DOB", " :  8th  August 1997"),
            SizedBox(height: 15,),
            buildRow("Address", " :  Kaveri block 5th cross Bettadasnapura Bengaluru 68"),
          SizedBox(height: 15,),
        Row(
            children: [
            Expanded(flex: 3,
            child: Text("Photo  ",style: TextStyle(color: Colors.white,fontSize: 17),)),
        Expanded(flex: 10,
            child: Container(height: 120,width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5)
              ),child:  Image.asset("assets/images/girl4.jpg"),
            )
        )
          ]
      ),
        
          Spacer(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
            ElevatedButton(
              onPressed: ()async {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>StaffdetailsEdit()));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.blueGrey.shade900,
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white, width: 2),
              ),
              child: const Text("EDIT"),
            ),
            SizedBox(width: 15,),
            ElevatedButton(
              onPressed: ()async {
                confirmDelete();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.blueGrey.shade900,
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white, width: 2),
              ),
              child: const Text("DELETE"),
            ),
          ],
        ),
            SizedBox(height: 15,),
        ]
      ),
      )
    );
  }
}
Widget buildRow(String title,String value){
  return Row(
    children: [
      Expanded(flex: 3,
          child: Text(title,style: TextStyle(color: Colors.white,fontSize: 17),)),
      Expanded(flex: 3,
          child: Text(value,style: TextStyle(color: Colors.white,fontSize: 17),))
    ],
  );
}