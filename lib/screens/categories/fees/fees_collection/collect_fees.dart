import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

import '../../../../dummydata/datas.dart';

class CollectFees extends StatefulWidget {
  const CollectFees({super.key});

  @override
  State<CollectFees> createState() => _CollectFeesState();
}

class _CollectFeesState extends State<CollectFees> {
  List<Map<String, dynamic>> feeEntries = [];
  String? selectedYear;
  TextEditingController nameController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController recievedByController = TextEditingController();
String? payment;
  Uint8List? _signatureImage;
  Uint8List? _parentSignatureImage;
  SignatureController signatureController = SignatureController(
      exportBackgroundColor: Colors.white,
      penColor: Colors.black,
      penStrokeWidth: 2
  );

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
                    onPressed: ()async {
                      final image = await signatureController.toPngBytes();
                      if (image != null && mounted) {
                        setState(() {
                          _signatureImage = image;
                        });
                      }
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
  void openParentSignatureDialog() {
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
                    onPressed: ()async {
                      final image = await signatureController.toPngBytes();
                      if (image != null && mounted) {
                        setState(() {
                          _parentSignatureImage = image;
                        });
                      }
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

  void msgbox(){
    showDialog(context: context, builder: (context)=>
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        title: Text("Message"),
        content: Text("Parent Fill Required Options"),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
        ],
      )
    );
  }

  void msg2box(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text("Message"),
          content: Text("Fees Received Successfully abd Receipt Number is 254"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
          ],
        )
    );
  }
  @override
  void initState() {
    super.initState();
    selectedYear = "2025-26";

    // Add one initial fee type row
    feeEntries.add({
      "type": "SCHOOL FEE",
      "controller": TextEditingController(),
    });
  }

  /// Add new fee field
  void addField() {
    setState(() {
      feeEntries.add({
        "type": "SCHOOL FEE",
        "controller": TextEditingController(),
      });
    });
  }

  /// Remove fee field
  void removeField(int index) {
    if(index !=0) {
      setState(() {
        feeEntries.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            Row(
              children: [
                Text("Academic Year",style: TextStyle(color: Colors.white,fontSize: 17),),
                SizedBox(width: 75,),
                Text(":  $selectedYear",style: TextStyle(color: Colors.white,fontSize: 17),),
              ],
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                  children:  feeEntries.asMap().entries.map ((entry) {
                    int index = entry.key;
                   return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [Expanded(
                          flex: 4,
                          child: DropdownButtonFormField<String>(
                              value: entry.value["type"],
                              isExpanded: true,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              items: feeTypes.map((String type) {
                                return DropdownMenuItem<String>(
                                  value: type,
                                  child: Text(type),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  entry.value["type"] = value!;
                                },
                                );
                              }),
                        ),
                          SizedBox(width: 10),

                          Expanded(
                            flex: 5,
                            child: TextField(
                              controller: entry.value["controller"],
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Amount",
                                hintStyle: TextStyle(color: Colors.grey),
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),

                          // 🗑️ Show delete icon only for entries after index 0
                          if (index != 0)
                            GestureDetector(
                              onTap: () => removeField(index),
                              child: const Icon(Icons.delete, color: Colors.red),
                            ),
                        ],
                      ),
                    );
                  }).toList()
              ),
            ),
         SizedBox(height: 20),
         GestureDetector(
           onTap: () {
               addField();
           },
        child: Row(
          children: const [
            Icon(Icons.add_circle, color: Colors.blue),
            SizedBox(width: 6),
            Text(
              "ADD FEES TYPES",
              style: TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
        SizedBox(height: 30,),
            buildRow("Collected From           :","Name", nameController),
            SizedBox(height: 20),
            Row(
                children: [
                  Expanded(flex: 4,child: Text("Payment Mode            : ",style: TextStyle(color: Colors.white,fontSize: 18),)),
                  Expanded(flex: 5,
                    child: DropdownButtonFormField<String>(
                        value: payment,isExpanded: true,
                        decoration: InputDecoration(fillColor: Colors.white,
                            filled: true,hintText: "Select Payment Mode",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                        items: ["Cash","Online Payment"].map((String value){
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,style: TextStyle(color: Colors.black),)
                          );
                        }).toList(),
                        onChanged: (value){
                          setState(() {
                            payment = value;
                          });
                        }),
                  ),
                ]
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                const Expanded(
                  flex: 4,
                  child: Text(
                    "Parent Signature             :",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: GestureDetector(
                    onTap: openParentSignatureDialog,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: _parentSignatureImage ==null
                        ? Center(
                        child: Text("Tap to Sign",style: TextStyle(color: Colors.grey),),
                      ): Image.memory(_parentSignatureImage!,fit: BoxFit.contain,)
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            buildRow("Contact No                 :","Number", numController),
            SizedBox(height: 20,),
            buildRow("Received by                :","Received By", recievedByController),
            SizedBox(height: 20,),
            Row(
              children: [
                const Expanded(
                  flex: 4,
                  child: Text(
                    "Signature                        :",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: GestureDetector(
                    onTap: openSignatureDialog,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: _signatureImage ==null
                          ? Center(
                        child: Text("Tap to Sign",style: TextStyle(color: Colors.grey),),
                      ): Image.memory(_signatureImage!,fit: BoxFit.contain,)
                    ),
                  ),
                ),
              ],
            ),
        SizedBox(height: 30,),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.white, width: 2),
              ),
              backgroundColor: Colors.blueGrey.shade900,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              if(_parentSignatureImage == null ||
                  payment == null ||
                  numController.text.trim().isEmpty ||
                  nameController.text.trim().isEmpty ||
                  recievedByController.text.trim().isEmpty){
                msgbox();
              }else{
               msg2box();
              }
            },
            child: const Text("SUBMIT"),
          ),
        )
          ],
        ),
      ),
    );
  }
}
Widget buildRow(String title,String hintText,TextEditingController controller){
  return  Row(
    children: [
       Expanded(
          flex: 4,
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),),
      Expanded(
        flex: 5,
        child: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,hintText: hintText,hintStyle: TextStyle(color: Colors.grey),
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5)),
          ),
        ),
      ),
    ],
  );
}