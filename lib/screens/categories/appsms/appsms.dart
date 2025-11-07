import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/appsms/daycare.dart';
import 'package:raynottschool/screens/categories/appsms/floating.dart';
import 'package:raynottschool/screens/categories/appsms/grade1.dart';
import 'package:raynottschool/screens/categories/appsms/grade2.dart';
import 'package:raynottschool/screens/categories/appsms/grade3.dart';
import 'package:raynottschool/screens/categories/appsms/grade4.dart';
import 'package:raynottschool/screens/categories/appsms/grade5.dart';
import 'package:raynottschool/screens/categories/appsms/grade6.dart';
import 'package:raynottschool/screens/categories/appsms/grade7.dart';
import 'package:raynottschool/screens/categories/appsms/grade7_state.dart';
import 'package:raynottschool/screens/categories/appsms/grade8.dart';
import 'package:raynottschool/screens/categories/appsms/lkg.dart';
import 'package:raynottschool/screens/categories/appsms/nursery.dart';
import 'package:raynottschool/screens/categories/appsms/ukg.dart';

class Appsms extends StatefulWidget {
  const Appsms({super.key});

  @override
  State<Appsms> createState() => _AppsmsState();
}

class _AppsmsState extends State<Appsms> {


  List<String> lists = [
    "Campus",
    "Staff",
    "NURSERY",
    "LKG",
    "UKG",
    "GRADE-1",
    "GRADE-2",
    "GRADE-3",
    "GRADE-4",
    "GRADE-5",
    "GRADE-6",
    "GRADE-7",
    "DAY CARE",
    "GRADE 8 STATE SYLLABUS",
    "Grade 7 STATE SYLLABUS"
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child:
      Scaffold(backgroundColor: Colors.white10,
      appBar: AppBar(backgroundColor: Colors.indigo.shade900,foregroundColor: Colors.white,
        bottom: TabBar(
          indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
          Tab(
            text: "UPDATES",
          ),
          Tab(text: "MOMENTS",)
        ])),body: TabBarView(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(itemBuilder: (context,index){
              final list = lists[index];
              return ListTile(
                onTap: (){
                  if(list=="NURSERY") {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Nursery()));
                  }else if(list=="LKG") {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Lkg()));
                  }else if(list=="UKG") {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Ukg()));
                  }else if(list=="GRADE-1") {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Grade1()));
                  }else if(list=="GRADE-2") {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Grade2()));
                  }else if(list=="GRADE-3") {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Grade3()));
                  }else if(list=="GRADE-4") {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Grade4()));
                  }else if(list=="GRADE-5") {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Grade5()));
                  }else if(list=="GRADE-6") {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Grade6()));
                  }else if(list=="GRADE-7") {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Grade7()));
                  }else if(list=="DAY CARE") {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Daycare()));
                  }else if(list=="GRADE 8 STATE SYLLABUS") {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Grade8()));
                  }else if(list=="GRADE 7 STATE SYLLABUS") {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Grade7State()));
                  }
                },
                leading: Text(list,style: TextStyle(color: Colors.white,fontSize: 16),),
                trailing: (list == "Campus" || list == "Staff")
                    ? const SizedBox() // empty if Campus or Staff
                    : Image.asset(
                  "assets/images/graduating-student (1).png",
                  width: 30,
                  height: 30,
                ),
              );
            }, separatorBuilder: (context,index)=>
                Divider(thickness: 0.4,indent: 0,endIndent: 0,height: 0,), itemCount: lists.length),
          ),
      Scaffold(backgroundColor: Colors.white10,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.pink,foregroundColor: Colors.white,
              shape: CircleBorder(),child: Icon(Icons.message_outlined),
              onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Floating()));
          }),
      )
      ]),
      ),
    );
  }
}
