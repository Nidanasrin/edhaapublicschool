import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendenceSettings extends StatefulWidget {
  const AttendenceSettings({super.key});

  @override
  State<AttendenceSettings> createState() => _AttendenceSettingsState();
}

class _AttendenceSettingsState extends State<AttendenceSettings> {
  final TextEditingController controller = TextEditingController();
bool isLoading = false;

  Future<void> uploadToFirebase()async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseFirestore.instance
          .collection('attendance')
          .doc('manual_attendance')
          .collection('attendance_settings')
          .doc('daily_attendance')
          .set({
        'attendance': controller.text,
        'updatedAt': DateTime.now()
      });
      setState(() {
        isLoading = false;
      });
      msgBox("Attendance Settings Submitted Successfully");
    }catch (e) {
      setState(() => isLoading = false);
      msgBox("Error uploading data: $e");
    }
  }

  void msgBox(String message){
    showDialog(context: context, builder: (context)=>
    AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text("Message",style: TextStyle(fontWeight: FontWeight.bold),),
      content: Text(message,style: TextStyle(fontSize: 16),),
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
            isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                :
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.white,width: 2))
              ),
                onPressed: () {
    if (controller.text.isNotEmpty) {
      uploadToFirebase();
    }else {
      msgBox("Please enter a number");
    }
    }, child: Text("SUBMIT"))
          ],
        ),
      ),
    );
  }
}
