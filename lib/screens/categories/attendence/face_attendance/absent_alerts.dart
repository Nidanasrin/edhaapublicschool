import 'package:cloud_firestore/cloud_firestore.dart';
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
          Navigator.pop(context);
          Navigator.pop(context);
        }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
      ],
    ));

  }
  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings()async{
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('alert_settings')
        .doc('alerts')
        .get();
    if(snap.exists){
      setState(() {
        isNotificationOn = snap['notifications'];
        isCallOn = snap['calls'];
        isSmsOn = snap['sms'];
      });
    }
  }
  Future<void> saveSettings()async{
    await FirebaseFirestore.instance
        .collection('alert_settings')
        .doc('alerts')
        .set({
      'notifications' : isNotificationOn,
      'calls' : isCallOn,
      'sms' : isSmsOn
    });
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
                  onPressed: ()async{
                    await saveSettings();
                    msgbox();
                  }, child: Text("SUBMIT")),
            )
          ],
        ),
      ),
    );
  }
}
