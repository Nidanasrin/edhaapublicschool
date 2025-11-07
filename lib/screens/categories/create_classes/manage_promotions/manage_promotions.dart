import 'package:flutter/material.dart';

class ManagePromotions extends StatefulWidget {
  const ManagePromotions({super.key});

  @override
  State<ManagePromotions> createState() => _ManagePromotionsState();
}

class _ManagePromotionsState extends State<ManagePromotions> {
  String? selectedValue;
  List<String> options = [
   "Lock",
   "Unlock"
  ];
  void msgBox(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text("Message"),
          content: Text("School Promotions Locked Successfully"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
          ],
        )
    );
  }
  void msgBox2(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text("Message"),
          content: Text("School Promotions Unlocked Successfully"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
          ],
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("EDHAA PUBLIC SCHOOL",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: Text("Status", style: TextStyle(color: Colors.white,fontSize: 16)),
            ),
            Expanded(
              flex: 5,
              child: DropdownButtonFormField<String>(
                value: selectedValue,
                isExpanded: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Status",
                  contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                items: options.map((String value) {
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
            SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(5)),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white,width: 2),
              ),
              onPressed: (){
                if(selectedValue==null){
                 msgBox2();
                }else{
                  msgBox();
                }
              },
              child: const Text("SUBMIT"),
            ),
          ],
        ),
      ),
    );
  }
}
