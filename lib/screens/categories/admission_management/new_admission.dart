import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:raynottschool/dummydata/datas.dart';

class NewAdmission extends StatefulWidget {
  const NewAdmission({super.key});

  @override
  State<NewAdmission> createState() => _NewAdmissionState();
}

class _NewAdmissionState extends State<NewAdmission> {
  TextEditingController initialController = TextEditingController();
  TextEditingController studentController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController fNoController = TextEditingController();
  TextEditingController mNameController = TextEditingController();
  TextEditingController mNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController prevSchoolController = TextEditingController();
  TextEditingController referredByController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  String? selectedValue;
  String? selectedGender;

  Future<void> pickDate()async{
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(1999),
        firstDate: DateTime(1980),
        lastDate: DateTime.now());
    if(pickedDate != null){
      setState(() {
        dobController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 10,),

              Row(
          children: [
          Expanded(
          flex: 1,
              child: buildField(initialController, "Initial",)),
          SizedBox(width: 10),
          Expanded(
            flex: 5,
            child: TextField(
              controller: studentController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,hintText: "Student Name",hintStyle: TextStyle(color: Colors.grey),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ),
          ],
              ),
              SizedBox(height: 10,),
              DropdownButtonFormField<String>(
                value: selectedValue,
                  isExpanded: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Class",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                  items: list.map((e)=> DropdownMenuItem<String>(
                    value: e,
                      child: Text(e,style: TextStyle(color: Colors.black),))).toList(),
                  onChanged: (value){
                  setState(() {
                    selectedValue = value;
                  });
                  }),
              SizedBox(height: 10,),
              TextField(
                onTap: (){
                  pickDate();
                },
                controller: dobController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "dd / MM / yyyy",
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.purple),
                    onPressed: pickDate,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text("Gender",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
              SizedBox(width: 20,),
              Radio<String>(
                activeColor: Colors.white,
                  value: "Male",
              groupValue: selectedGender,
              onChanged: (value){
                  setState(() {
                    selectedGender = value;
                  });
              },),
                  Text("Male",style: TextStyle(color: Colors.white,fontSize: 16),),
                  SizedBox(width: 20,),
                  Radio<String>(value: "Female",
                  activeColor: Colors.white,
                  groupValue: selectedGender,
                  onChanged: (value){
                    setState(() {
                      selectedGender = value;
                    });
                  },),
                  Text("Female",style: TextStyle(color: Colors.white,fontSize: 16),)
                  ]
              ),
              SizedBox(height: 10,),
              buildField(fNameController, "Father Name"),
              SizedBox(height: 10,),
              buildField(fNoController, "Father Mobile No",TextInputType: TextInputType.phone),
              SizedBox(height: 10,),
              buildField(fNoController, "Mother Name",),
              SizedBox(height: 10,),
              buildField(mNoController, "Mother Mobile No",TextInputType: TextInputType.phone),
              SizedBox(height: 10,),
              buildField(addressController, "Address",maxLine: 3),
              SizedBox(height: 10,),

              buildField(prevSchoolController, "Previous School Name",),
              SizedBox(height: 10,),

              buildField(referredByController, "Referred By",),
              SizedBox(height: 10,),

              buildField(commentsController, "Comments",maxLine: 3),
              SizedBox(height: 20,),

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
                    if(selectedGender == null || selectedValue == null || dobController.text.isEmpty || prevSchoolController.text.isEmpty || addressController.text.isEmpty || mNoController.text.isEmpty || mNameController.text.isEmpty || fNoController.text.isEmpty || fNameController.text.isEmpty || studentController.text.isEmpty ){
                      Fluttertoast.showToast(msg: "Please fill all the details",toastLength: Toast.LENGTH_SHORT,backgroundColor: Colors.red.shade700,gravity: ToastGravity.CENTER,textColor: Colors.white);
                    }else{
                      Fluttertoast.showToast(msg: "New Admission Added Successfully",toastLength: Toast.LENGTH_SHORT,backgroundColor: Colors.red.shade700,gravity: ToastGravity.CENTER,textColor: Colors.white);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("SUBMIT"),
                ),
              ),
           SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }
}
Widget buildField(TextEditingController controller,String hintText,{TextInputType? TextInputType,int maxLine = 1}){
  return TextField(
          controller: controller,
          style:  TextStyle(color: Colors.black),keyboardType: TextInputType,
          maxLines: maxLine,
          decoration: InputDecoration(
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5)),
          ),
  );
}