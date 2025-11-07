import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/calendar/add_events2.dart';

class AddEvents extends StatefulWidget {
  const AddEvents({super.key});

  @override
  State<AddEvents> createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        children: [
          Spacer(),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.white, width: 2),
                ),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddEvents2()
                      )
                  );

              },
              child: Text("ADD EVENTS"),
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
