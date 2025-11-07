import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';

class AddNewpoc extends StatefulWidget {
  const AddNewpoc({super.key});

  @override
  State<AddNewpoc> createState() => _AddNewpocState();
}

class _AddNewpocState extends State<AddNewpoc> {
   List<String> selectedStaff = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            Expanded(
              child: ListView.separated(itemBuilder: (context,index){
                final name = staffNames[index];
                final isSelected = selectedStaff.contains(name);
                return ListTile(
                  leading: Checkbox(
                    activeColor: Colors.green,
                      checkColor: Colors.grey,
                      value: isSelected, onChanged: (value){
                      setState(() {
                        if(value ==true) {
                          selectedStaff.add(name);
                        }else{
              selectedStaff.remove(name);
                        }
                      });
                  }),
                  title: Text(
                    name,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }, separatorBuilder: (context,index)=> Divider(thickness: 1,height: 5,), itemCount: staffNames.length),
            ),
            Center(
              child: ElevatedButton(
                         onPressed: (){
                           Navigator.pop(context, selectedStaff);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: Colors.blueGrey.shade900,
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.white, width: 2),
                ),
                child: const Text("SUBMIT"),
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
