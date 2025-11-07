import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/support_tickets/Raise_tickets/status_details.dart';

class TicketStatus extends StatefulWidget {
  const TicketStatus({super.key});

  @override
  State<TicketStatus> createState() => _TicketStatusState();
}

class _TicketStatusState extends State<TicketStatus> {
  List<String> status = [
    'Close',
    'In Progress',
    'Close',
    'Close',
    'Close',
    'Close'
  ];
  List<String> date = [
    '08/10/2025',
    '16/10/2025',
    '05/10/2025',
    '25/10/2025',
    '16/10/2025',
    '10/10/2025'
  ];
  List<String> description = [
    'Marks Updated Issues',
    'Hall Ticket Issue',
    'Arya RECEIPT NO 7,10,11 & 12',
    'Aneesh Receipt No 14 should be removed',
    'Arya Nursery Receipt No 14 Should be Removed',
    'HELEN RECEIPT NUM 14'
  ];
  List<int> lists = [
    1676,
  1650,
      1583,
      1543,
       1629,
      1501,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
            itemBuilder: (context,index){
          final item = lists[index];
          final statuses = status[index];
          return ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> StatusDetails(status: statuses, date: date[index], description: description[index],)));
            },
            title: Text(item.toString(),style: TextStyle(color: Colors.white),),
            trailing: Text(statuses,style: TextStyle(color: Colors.white,fontSize: 16),),
          );
            }, separatorBuilder: (context,index)=>Divider(height: 0,color: Colors.white,thickness: 1,),  itemCount: lists.length),
      ),
    );
  }
}
