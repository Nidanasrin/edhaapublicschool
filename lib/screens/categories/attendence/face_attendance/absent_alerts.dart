import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/attendence/face_attendance/settings.dart';

class AbsentAlerts extends StatefulWidget {
  const AbsentAlerts({super.key});

  @override
  State<AbsentAlerts> createState() => _AbsentAlertsState();
}

class _AbsentAlertsState extends State<AbsentAlerts> {

  bool isNotificationOn = false;
  bool isCallOn = false;
  bool isSmsOn = false;

  void msgbox(){
    showDialog(context: context, builder: (context)=>
    AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text("Message"),
      content: Text("Notification Settings Updated."),
      actions: [
        TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Settings()));
        }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
      ],
    ));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            Row(
              children: [
                Expanded(child: Text("Notifications",style: TextStyle(color: Colors.white,fontSize: 17),)),
                Expanded(child: Switch(
                    activeThumbColor: Colors.pink,
                    value: isNotificationOn, onChanged: (value){
                  setState(() {
                    isNotificationOn = value;
                  });
                }))
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(child: Text("Voice Calls",style: TextStyle(color: Colors.white,fontSize: 17),)),
                Expanded(child: Switch(
                  activeThumbColor: Colors.pink,
                    value: isCallOn, onChanged: (value){
                  setState(() {
                    isCallOn = value;
                  });
                }))
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(child: Text("SMS",style: TextStyle(color: Colors.white,fontSize: 17),)),
                Expanded(child: Switch(
                    activeThumbColor: Colors.pink,
                    value: isSmsOn, onChanged: (value){
                  setState(() {
                    isSmsOn = value;
                  });
                }))
              ],
            ),
            SizedBox(height: 60.0,),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape:
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.white,width: 2),
                      ),backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white
                  ),
                  onPressed: (){
                    msgbox();
                  }, child: Text("SUBMIT")),
            )
          ],
        ),
      ),
    );
  }
}
