import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class RaiseTickets extends StatefulWidget {
  const RaiseTickets({super.key});

  @override
  State<RaiseTickets> createState() => _RaiseTicketsState();
}

class _RaiseTicketsState extends State<RaiseTickets> {
  TextEditingController issuedByController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController desController = TextEditingController();
  Uint8List? _signatureImage;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 2, color: Colors.black),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel",style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 2, color: Colors.black),
                  ),
                ),
                onPressed: () {
                  signatureController.clear();
                },
                child: const Text(
                  'Clear',
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 2, color: Colors.black),
                  ),
                ),
                onPressed: () async {
                  final image = await signatureController.toPngBytes();
                  if (image != null && mounted) {
                    setState(() {
                      _signatureImage = image;
                    });
                  }
                  Navigator.pop(context);
                },
                child: const Text(
                  'Done',
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List <String> items = [
  'Accounts',
  'Customer Care',
  'Sales',
  'Technical',
  'New Requirement'
];
String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
                Row(
                children: [
                Expanded(
                flex: 5,
          child: Text("Issue To", style: TextStyle(color: Colors.white,fontSize: 16)),
                ),
                Expanded(
          flex: 5,
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            isExpanded: true,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "Issue To",
              contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.black)),
              );
            }).toList(),
            onChanged: (value){
              selectedValue = value;
            },
          ),
                ),
                ],
              ),
          SizedBox(height: 10,),
          buildRowField(issuedByController, "Issued By", "Issued By"),
            SizedBox(height: 10,),
            buildRowField(contactNoController, "Contact No", "Contact No"),
            SizedBox(height: 10,),
            buildRowField(desController, "Description", "Description"),
            SizedBox(height: 10,),
            Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Text(
                    "Signature",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: openSignatureDialog,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: _signatureImage == null
                          ? Center(
                        child: Text(
                          "Tap to Sign",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                          : Image.memory(_signatureImage!, fit: BoxFit.contain),
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
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(color: Colors.white, width: 2),
                  ),
                  backgroundColor: Colors.blueGrey.shade900,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  if(issuedByController.text.isEmpty ||
                      contactNoController.text.isEmpty || selectedValue == null || desController.text.isEmpty ||
                      _signatureImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill all fields and add a signature")),
                    );
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Tickets added successfully")),
                  );
                },
                child: const Text("SUBMIT"),
              ),
            )
          ],
                ),
        ),
      )
    );
  }
}
Widget buildRowField(TextEditingController controller,String hintText,String title,{int maxLine =1,TextInputType? TextInputType}) {
 return Row(
    children: [
      Expanded(
        flex: 5,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      Expanded(
        flex: 5,
        child: TextField(
          controller: controller,
          keyboardType: TextInputType,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    ],
  );
}