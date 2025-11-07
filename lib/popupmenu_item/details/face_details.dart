import 'package:flutter/material.dart';

class FaceDetails extends StatefulWidget {
  const FaceDetails({super.key});

  @override
  State<FaceDetails> createState() => _FaceDetailsState();
}

class _FaceDetailsState extends State<FaceDetails> {
  TextEditingController totalController = TextEditingController();
  TextEditingController notesController= TextEditingController();
  TextEditingController othersamountController = TextEditingController();
  String? selectedAmount;

  int get totalPayable{
    if(totalController.text.isEmpty) return 0;
    return int.tryParse(totalController.text) ?? 0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            Row(
              children: [
                Expanded(flex: 2,
                    child: Text('1. Total Students',style: TextStyle(color: Colors.white,fontSize: 16),)),
                Expanded(flex: 3,
                  child: TextField(
                    controller: totalController,
                    decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),),
                      filled: true,
                      fillColor: Colors.white,
                       hintText: 'Total Students',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    keyboardType: TextInputType.phone,onChanged: (_){
                    setState(() {

                    });
                  },
                  )
                )
              ],
            ),
            SizedBox(height: 25,),
            Text('2. Notes',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
            SizedBox(height: 8,),
            TextField(
              controller: notesController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Total Students',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 25,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(flex: 3,
                    child: Row(
                        children: [
                          Radio<String>(value: 'Total Payable Amount',
                            activeColor: Colors.white,
                            groupValue: selectedAmount,
                            onChanged: (value){
                              setState(() {
                                selectedAmount = value;

                              });
                            },
                          ),
                          Text('Total Payable Amount',style: TextStyle(color: Colors.white,fontSize: 16),),
                        ]
                    ),
                  ),
                  Expanded(flex: 1,
                      child: Text('₹${totalPayable * 100}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),)),
                ]
            ),
            SizedBox(height: 15,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(flex: 3,
                  child:
                  Row(
                      children: [
                        Radio<String>(value: 'Others Amount',
                          activeColor: Colors.white,
                          focusColor: Colors.white,

                          groupValue: selectedAmount,
                          onChanged: (value){
                            setState(() {
                              selectedAmount = value;
                            });
                          },
                        ),
                        Text('Others Amount',style: TextStyle(color: Colors.white,fontSize: 16),),
                      ]
                  ),
                ),
                Expanded(flex: 2,
                  child: TextField(
                    controller: othersamountController,
                    decoration: InputDecoration(
                      hintText: 'Others Amount',
                      hintStyle: TextStyle(color: Colors.grey,),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 25,),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (notesController.text.isEmpty || selectedAmount!.isEmpty || totalController.text.isEmpty ){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all the details")));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey.shade900,
                  side: const BorderSide(color: Colors.white,width: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                ),
                child: const Text("PLACE ORDER", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
