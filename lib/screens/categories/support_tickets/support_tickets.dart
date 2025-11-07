import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/support_tickets/Raise_tickets/raise_tickets.dart';
import 'package:raynottschool/screens/categories/support_tickets/Raise_tickets/ticket_status.dart';

class SupportTickets extends StatefulWidget {
  const SupportTickets({super.key});

  @override
  State<SupportTickets> createState() => _SupportTicketsState();
}

class _SupportTicketsState extends State<SupportTickets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body:
      Center(
      child:  Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> RaiseTickets()));
              },
              child: buildContainer("RAISE TICKETS"),),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> TicketStatus()));
              },
              child:
              buildContainer("TICKET STATUS"),
            )
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