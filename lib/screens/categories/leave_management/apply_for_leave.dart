import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

class ApplyForLeave extends StatefulWidget {
  const ApplyForLeave({super.key});

  @override
  State<ApplyForLeave> createState() => _ApplyForLeaveState();
}

class _ApplyForLeaveState extends State<ApplyForLeave> {
  DateTime? fromDate;
  DateTime? toDate;
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  Uint8List? _signatureImage;
  SignatureController signatureController = SignatureController(
      exportBackgroundColor: Colors.white,
      penColor: Colors.black,
      penStrokeWidth: 2
  );

  Future<void> _pickDate(TextEditingController controller, bool isFrom) async {
    DateTime initialDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
        if (isFrom) {
          fromDate = pickedDate;
        } else {
          toDate = pickedDate;
        }
      });
    }
  }

  @override
  void dispose() {
    fromDateController.dispose();
    toDateController.dispose();
    reasonController.dispose();
    signatureController.dispose();
    super.dispose();
  }

  void saveRemark() {
    if (reasonController.text.isEmpty ||
        fromDateController.text.isEmpty ||
        toDateController.text.isEmpty ||
        _signatureImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields and add a signature")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Remarks added successfully")),
    );

    // ✅ Clear fields
    setState(() {
      fromDateController.clear();
      toDateController.clear();
      reasonController.clear();
      _signatureImage = null;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "Reason for leave",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextField(
                controller: reasonController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Reason",
                  hintStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
            SizedBox(height: 15,),
            Row(
              children: [
            Expanded(flex: 1,
                child: Text("From Date", style: TextStyle(color: Colors.white,fontSize: 16))),
            Expanded(flex: 2,
              child: TextField(
                onTap: ()=> _pickDate(fromDateController, true),
                controller: fromDateController,
                readOnly: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.blueGrey),
                    onPressed: () => _pickDate(fromDateController, true),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  hintText: 'From Date',
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
            ]
            ),
             SizedBox(height: 15),
             Row(
               children: [
             Expanded(child: Text("To Date", style: TextStyle(color: Colors.white,fontSize: 16))),
            Expanded(flex: 2,
              child: TextField(
                onTap:()=> _pickDate(toDateController,false),
                controller: toDateController,
                readOnly: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.blueGrey),
                    onPressed: () => _pickDate(toDateController, false),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  hintText: 'To Date',
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
          SizedBox(height: 15,),
          Row(
            children: [
              const Expanded(
                flex: 1,
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
            SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey.shade900,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 2, color: Colors.white),
                ),
              ),
              onPressed: () {
                if(reasonController.text.isEmpty || signatureController.isEmpty || reasonController.text.isEmpty ||fromDateController.text.isEmpty || toDateController.text.isEmpty ){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all the details")));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Leave Applied Successfully")));
                }

              },
              child: const Text(
                'APPLY FOR LEAVE',
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
              ),
            ),
        ]
        )
      ),
    );
  }
}
