import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/create_classes/classes_sorting_order/classes_sorting_order.dart';
import 'package:raynottschool/screens/categories/create_classes/create_class/create_class.dart';
import 'package:raynottschool/screens/categories/create_classes/manage_promotions/manage_promotions.dart';
import 'package:raynottschool/screens/categories/create_classes/promote_students/promote_students.dart';

class CreateClasses extends StatefulWidget {
  const CreateClasses({super.key});

  @override
  State<CreateClasses> createState() => _CreateClassesState();
}

class _CreateClassesState extends State<CreateClasses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child:  Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateClass()));
                },
                child:
                buildContainer("CREATE CLASSES"),
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PromoteStudents()));
                },
                child:
                buildContainer("PROMOTE STUDENTS"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ManagePromotions()));
                },
                child:
                buildContainer("MANAGE PROMOTIONS"),),
              SizedBox(height: 15,),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ClassesSortingOrder()));
                  },
                  child:
                  buildContainer("CLASSES SORTING ORDER")),
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
