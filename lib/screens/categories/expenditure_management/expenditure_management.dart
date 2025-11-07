import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/expenditure_management/account_statement/account_statement.dart';
import 'package:raynottschool/screens/categories/expenditure_management/expenditure_item/expenditure_item.dart';

class ExpenditureManagement extends StatefulWidget {
  const ExpenditureManagement({super.key});

  @override
  State<ExpenditureManagement> createState() => _ExpenditureManagementState();
}

class _ExpenditureManagementState extends State<ExpenditureManagement> {
  void msgbox(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text("Message"),
          content: Text("No Expenditure for Approval"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
          ],
        )
    );
  }
  void itemWise(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text("Message"),
          content: Text("Please Create Expenditure Items"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
          ],
        )
    );
  }
  void bookingDoalog(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text("Message"),
          content: Text("Please create Expenditure Items"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
          ],
        )
    );
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
              msgbox();
              },
                child: buildContainer("EXPENDITURE APPROVALS"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
bookingDoalog();                },
                child:
                buildContainer("EXPENDITURE BOOKINGS"),
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ExpenditureItem()));
                },
                child:
                buildContainer("EXPENDITURE ITEMS"),),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AccountStatement()));
                },
                child:
                buildContainer("ACCOUNTS STATEMENTS"),),
              SizedBox(height: 15,),
              GestureDetector(
                  onTap: (){
                     itemWise();
                                       },
                  child:
                  buildContainer("ITEM WISE STATEMENT")),
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