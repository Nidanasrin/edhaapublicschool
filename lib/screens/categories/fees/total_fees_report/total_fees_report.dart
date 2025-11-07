import 'package:flutter/material.dart';

class TotalFeesReport extends StatefulWidget {
  const TotalFeesReport({super.key});

  @override
  State<TotalFeesReport> createState() => _TotalFeesReportState();
}

class _TotalFeesReportState extends State<TotalFeesReport> {

  TextEditingController otpController = TextEditingController();
  void msgBox(){
    showDialog(context: context, builder: (context)=>
    AlertDialog(backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    title: Text("Please enter the One Time Password (OTP) which was sent to your registered mobile number to view the Fees Reports",style: TextStyle(fontSize: 16),),
    content: Column(mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("One Time Password",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
        SizedBox(height: 15,),
        TextField(
          decoration: InputDecoration(border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),hintText: "One Time Password",
          hintStyle: TextStyle(color: Colors.grey)),
        ),
      ],
    ),
      actions: [
        Center(
          child: ElevatedButton(style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 2,color: Colors.black)
              )
          ),
            onPressed: ()async {
            if(otpController.text.isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill OTP")));
            }else {
              Navigator.pop(context);
            }
            },
            child: const Text('SUBMIT',style: TextStyle(fontWeight: FontWeight.bold),),
          ),
        ),
      ],
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Text("To Access Fees Reports more Authentication needed",style: TextStyle(color: Colors.white,fontSize: 17),)),
            SizedBox(height: 20,),
            ElevatedButton(style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey.shade900,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 2,color: Colors.white)
                )
            ),
              onPressed: ()async {
                msgBox();
              },
              child: const Text('VERIFY ME'),
            ),
          ],
        ),
      ),
    );
  }
}
