import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class tags_details extends StatefulWidget {
  const tags_details({super.key});

  @override
  State<tags_details> createState() => _tags_detailsState();
}

class _tags_detailsState extends State<tags_details> {
  TextEditingController amountController = TextEditingController();
  TextEditingController smallController = TextEditingController();
  TextEditingController mediumController = TextEditingController();
  TextEditingController largeController = TextEditingController();
  TextEditingController exlargeController = TextEditingController();
  TextEditingController orgNameController = TextEditingController();
  bool photoSelected = false;
  File? selectedImage;
  String? selectedValue;
  String? selectedAmount;

  int get totalPayment{
    int small = int.tryParse(smallController.text) ?? 0;
    int medium = int.tryParse(mediumController.text) ?? 0;
    int large = int.tryParse(largeController.text) ?? 0;
    int exlarge = int.tryParse(exlargeController.text) ?? 0;
int totalQty = small + medium + large + exlarge;
return totalQty * 40;
  }
  Widget buildRowField(
      String label,
      String label2,
      TextEditingController controller,
      TextEditingController controller2,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildField(label, controller),
        buildField(label2, controller2),
      ],
    );
  }

  // ✅ Move buildField here
  Widget buildField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 15)),
        const SizedBox(height: 6),
        SizedBox(
          width: 160,
          height: 45,
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'Enter Quantity',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
            keyboardType: TextInputType.number,
            onChanged: (_) {
              setState(() {}); // ✅ Now it works
            },
          ),
        ),
      ],
    );
  }
List<String> items = [
  'Horizontal',
  'Vertical'
];
  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }


  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  void msgBox(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(backgroundColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            content: Column(mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    pickImage();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.indigo.shade900,
                    side: BorderSide(color: Colors.indigo.shade900, width: 2),
                  ),
                  child: const Text("OPEN CAMERA"),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {
                    _pickImageFromGallery();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.indigo.shade900,
                    side: BorderSide(color: Colors.indigo.shade900, width: 2),
                  ),
                  child: const Text("PICK IMAGE FROM GALLERY"),
                ),
              ],
            )
        ));
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
            SizedBox(height: 40,),
            Text("1. Choose Size & Quantity",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
            SizedBox(height: 25,),
            buildRowField('70CM (Small)', '80CM (Medium)', smallController, mediumController),
            SizedBox(height: 25,),
            buildRowField('90CM (Large)', '100CM (Extra Large)', largeController, exlargeController),
            SizedBox(height: 25,),
            Text("2. Organization Details",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
            SizedBox(height: 10,),
            TextField(
              controller: orgNameController,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Enter Organization Name',
                hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              ),
            ),
            SizedBox(height: 25,),
            Row(
              children: [
                const Expanded(
                  flex: 4,
                  child: Text(
                    "Upload Organization Logo                  ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ),
                Expanded(
                    flex: 5,
                    child: GestureDetector(
                      onTap: () {
                        msgBox();
                        setState(() {
                          photoSelected = !photoSelected;
                        });
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[800],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white),
                          image: photoSelected
                              ? const DecorationImage(
                            image: AssetImage("assets/sample.jpg"),
                            fit: BoxFit.cover,
                          )
                              : null,
                        ),
                        child: !photoSelected
                            ? const Icon(
                            Icons.add_a_photo, color: Colors.white)
                            : null,
                      ),
                    )
                ),
              ],
            ),
            SizedBox(height: 25,),
        Row(
          children: [
            Expanded(
                flex: 4,
                child: Text('Attachment Type', style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold))),
            Expanded(
              flex: 5,
              child: DropdownButtonFormField<String>(
                value: selectedValue,
                isExpanded: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                ),
                items: items
                    .map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e, style: TextStyle(color: Colors.black)),
                ))
                    .toList(),
                onChanged: (value){
                  selectedValue = value;
                },
              ),
            ),
          ],
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
                    child: Text('₹$totalPayment',style: TextStyle(color: Colors.white),)),
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
                      controller: amountController,
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
                  if (orgNameController.text.isEmpty || selectedAmount!.isEmpty || selectedValue == null || amountController.text.isEmpty ){
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
        )
    );
  }
}
// Widget buildRowField(
//     String label,
//     String label2,
//     TextEditingController controller,
//     TextEditingController controller2,
//     ) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       buildField(label, controller),
//       buildField(label2, controller2),
//     ],
//   );
// }

//
// Widget buildField(String label, TextEditingController controller) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(label, style: const TextStyle(color: Colors.white, fontSize: 15)),
//       const SizedBox(height: 6),
//       SizedBox(
//         width: 160, // 👈 fixed width to prevent layout issues
//         height: 45,
//         child: TextField(
//           controller: controller,
//           decoration: const InputDecoration(
//             fillColor: Colors.white,
//             filled: true,
//             hintText: 'Enter Quantity',
//             hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
//             border: OutlineInputBorder(),
//             contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//           ),
//           keyboardType: TextInputType.number,
//           onChanged: (_){
//             setState((){});
//           },
//         ),
//       ),
//     ],
//   );
// }