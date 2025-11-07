import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

class Applyforcertification extends StatefulWidget {
  const Applyforcertification({super.key});

  @override
  State<Applyforcertification> createState() => _ApplyforcertificationState();
}

class _ApplyforcertificationState extends State<Applyforcertification> {
  late String todayDate;
SignatureController signatureController = SignatureController(
  exportBackgroundColor: Colors.white,
  penColor: Colors.black,
  penStrokeWidth: 2
);
  @override
  void initState(){
    super.initState();
    todayDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }
  @override
  void dispose() {
    signatureController.dispose();
    super.dispose();
  }
  void openSignatureDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          "Signature Panel",
          style: TextStyle(color: Colors.black),
        ),
        content: SizedBox(
        width: double.maxFinite,
        height: 200, // Make sure the height is enough
        child: Signature(
          controller: signatureController,
          backgroundColor: Colors.grey.shade200, // Light gray to see strokes
        ),
      ),
        actions: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
          ElevatedButton(style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(width: 2,color: Colors.black)
            )
          ),
              onPressed: (){
            Navigator.pop(context);
    }, child: Text("Cancel")),
          ElevatedButton(style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 2,color: Colors.black)
              )
          ),
            onPressed: () {
              signatureController.clear();
            },
            child: const Text('Clear', style: TextStyle(color: Colors.black)),
          ),
          ElevatedButton(style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 2,color: Colors.black)
              )
          ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Done', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    ]
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white10,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0,),
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Date : $todayDate",style: TextStyle(fontSize: 16,color: Colors.white),),
              ],
            ),
            SizedBox(height: 5,),
            Text("To",style: TextStyle(fontSize: 16,color: Colors.white),),
            Text("Certificate Department,",style: TextStyle(fontSize: 16,color: Colors.white),),
            Text("Student Unique Card.",style: TextStyle(fontSize: 16,color: Colors.white),),
            SizedBox(height: 10,),
            Text("SUB : Applying for Student Unique Card's Certified Digital Campus Initial Stage Certification.",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white),),
            SizedBox(height: 10,),
            Text("Dear Team,",style: TextStyle(fontSize: 16,color: Colors.white),),
            Text("This is to inform you that we are completed our Initial State Program as per your norms to become an eligible Stiudent Unique Cards Certified Initial Stage Digital Campus. Kindly issue the Certificate.",style: TextStyle(fontSize: 16,color: Colors.white),),
            SizedBox(height: 10,),
            Text("Warm Regards,",style: TextStyle(fontSize: 16,color: Colors.white),),
            SizedBox(height: 30,),
            Row(
              children: [
                Text("Signature    :",style: TextStyle(fontSize: 16,color: Colors.white),),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: (){
                    openSignatureDialog();
                  },
                  child: Container(height: 100,width: 100,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white,width: 2),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 100,),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 2,color: Colors.white),
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                  onPressed: (){}, child: Text("NEXT")),
            )
          ],
        ),
      ),
    );
  }
}
