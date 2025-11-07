import 'package:flutter/material.dart';

class AttendenceSettings extends StatefulWidget {
  const AttendenceSettings({super.key});

  @override
  State<AttendenceSettings> createState() => _AttendenceSettingsState();
}

class _AttendenceSettingsState extends State<AttendenceSettings> {
  final TextEditingController controller = TextEditingController();

  void msgBox(){
    showDialog(context: context, builder: (context)=>
    AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text("Message",style: TextStyle(fontWeight: FontWeight.bold),),
      content: Text("Attendance Settings Submitted Successfully",style: TextStyle(fontSize: 16),),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Cancel",style: TextStyle(color: Colors.indigo.shade900),)),
        SizedBox(width: 10,),
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
      ],
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Center(
                child: Row(
                  children: [
                     Expanded(child: Text("How many times do you want to take attendance daily",style: TextStyle(color: Colors.white,fontSize: 18),)),
      Expanded(child:  TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "Enter number",
          border: OutlineInputBorder(),
        ),
                    )
      )
                  ],
                ),
              ),

            SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.white,width: 2))
              ),
                onPressed: () {
    if (controller.text.isNotEmpty) {
    msgBox();
    }
    }, child: Text("SUBMIT"))
          ],
        ),
      ),
    );
  }
}
