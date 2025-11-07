import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InwardOutward extends StatefulWidget {
final Function(BuildContext)? onInit;
  const InwardOutward({super.key, this.onInit});

  @override
  State<InwardOutward> createState() => _InwardOutwardState();
}

class _InwardOutwardState extends State<InwardOutward> {
  String? selectedValue;
  String? selectedItem;
  List<String> items = [
    "Inward",
    "Outward"
  ];
  TextEditingController itemController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  File? selectedImage;
  bool photoSelected = false;

  Future<void> _pickImage() async {
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

  void imagebox(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
          backgroundColor: Colors.white,
          content: Column(mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,

                      side: BorderSide(color: Colors.indigo.shade900,width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  onPressed: pickImage, child: Text("OPEN CAMERA",style: TextStyle(color: Colors.indigo.shade900),)),
              SizedBox(height: 10,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.indigo.shade900,width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  onPressed: _pickImage, child: Text("PICK IMAGE FROM GALLERY",style: TextStyle(color: Colors.indigo.shade900),))
            ],
          ),
        ));
  }


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.onInit != null) widget.onInit!(context);
    });
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
        buildRowDropDown("Select", "Select", selectedValue, items, (value){
          selectedValue = value!;
        }),
            SizedBox(height: 10,),
            buildRow("Item Name", "Item Name", itemController),
            SizedBox(height: 10,),
            buildRow("Quantity", "Number", quantityController),
            SizedBox(height: 10,),
            buildRow("Weight", "Kgs", weightController),
            SizedBox(height: 10,),
            buildRow("Received by/HandOver to", "Name", nameController),
            SizedBox(height: 10,),
            buildRow("Comments", "Description", commentsController),
            SizedBox(height: 20,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade900,
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white,width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                onPressed: (){}, child: Text("SUBMIT",))
          ],
        ),
      ),
    );
  }
}

Widget buildRow(String title,String hintText,TextEditingController controller){
  return  Row(
    children: [
      Expanded(flex: 5,
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      Expanded(flex: 5,
        child: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,hintText: hintText,hintStyle: TextStyle(color: Colors.grey,fontSize: 16),
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5)),
          ),
        ),
      ),
    ],
  );
}
Widget buildRowDropDown(
    String title,
    String hintText,
    String? selectedValue,
    List<String> items,
    ValueChanged<String?> onChanged,
    ) {
  return Row(
    children: [
      Expanded(
        flex: 5,
        child: Text(title, style: TextStyle(color: Colors.white,fontSize: 16)),
      ),
      Expanded(
        flex: 5,
        child: DropdownButtonFormField<String>(
          value: selectedValue,
          isExpanded: true,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
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
          onChanged: onChanged,
        ),
      ),
    ],
  );
}