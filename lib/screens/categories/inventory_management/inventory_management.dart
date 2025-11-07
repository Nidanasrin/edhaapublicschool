import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/inventory_management/inward_outward/inward_outward.dart';
import 'package:raynottschool/screens/categories/inventory_management/materials_list/materials_list.dart';

class InventoryManagement extends StatefulWidget {
  const InventoryManagement({super.key});

  @override
  State<InventoryManagement> createState() => _InventoryManagementState();
}

class _InventoryManagementState extends State<InventoryManagement> {

  void msgBox() {
    showDialog(context: context, builder: (context) =>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
          ),
          title: Text("Message"),
          content: Text(
              "No Information Available"),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
                child: Text(
                  "Ok", style: TextStyle(color: Colors.indigo.shade900),))
          ],
        ));
  }
  void openInwardAndShowDialog() {
    Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => InwardOutward(
          onInit: (context){
          Future.delayed(Duration(microseconds: 300),
              ()=> msgBox());
          }
    )
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child:  Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
openInwardAndShowDialog();                },
                child: buildContainer("INWARD/OUTWARD"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MaterialsList()));
                },
                child:
                buildContainer("MATERIALS LIST"),
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
msgBox();
},
                child:
                buildContainer("MATERIALS STATUS"),),
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
