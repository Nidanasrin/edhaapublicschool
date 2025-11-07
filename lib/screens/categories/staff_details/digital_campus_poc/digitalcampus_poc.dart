import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/staff_details/digital_campus_poc/add_newpoc.dart';

class DigitalcampusPoc extends StatefulWidget {
  const DigitalcampusPoc({super.key});

  @override
  State<DigitalcampusPoc> createState() => _DigitalcampusPocState();
}

class _DigitalcampusPocState extends State<DigitalcampusPoc> {
  List<String> pocList = [];

  void msgBox(){
    showDialog(context: context, builder: (context)=>
    AlertDialog(backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    title: Text("Message"),
    content: Text("Do you want to dial this number?"),
    actions: [
      TextButton(onPressed: (){
        Navigator.pop(context);
      }, child: Text("NO",style: TextStyle(color: Colors.indigo.shade900),)),
      TextButton(onPressed: (){
        Navigator.pop(context);
      }, child: Text("YES",style: TextStyle(color: Colors.indigo.shade900),))
    ],));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 35,),
            Expanded(child: pocList.isEmpty ?
            Center(
              child: Text("No POCs added",style: TextStyle(color: Colors.white),),
            ): ListView.separated(
              itemCount: pocList.length,
              separatorBuilder: (context, index) =>
              const Divider(color: Colors.white),
              itemBuilder: (context, index) {
                final name = pocList[index];
                return ListTile(
                  title:
                      Text(
                        name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                  subtitle: const Text(
                    "Designation: Admin\nMobile No: 8374037251",
                    style: TextStyle(color: Colors.white70),
                  ),
                  trailing: Wrap(
                    direction: Axis.horizontal,
                    spacing: 2, // small gap between icons
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            pocList.removeAt(index);
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.call, color: Colors.blue),
                        onPressed: () {
                         msgBox();

                        },
                      ),
                    ],
                  ),

                );
              },
            ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: ()async {
                  final selectedStaff = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  AddNewpoc()),
                  );

                  // Check if something was returned
                  if (selectedStaff != null && selectedStaff is List<String>) {
                    setState(() {
                      pocList.addAll(selectedStaff); // Add to the list
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: Colors.blueGrey.shade900,
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.white, width: 2),
                ),
                child: const Text("ADD NEW POC"),
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
