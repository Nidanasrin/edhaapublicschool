import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';

class AddAccountant extends StatefulWidget {
  const AddAccountant({super.key});

  @override
  State<AddAccountant> createState() => _AddAccountantState();
}

class _AddAccountantState extends State<AddAccountant> {
  String? selectStaff;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Row(
        children: [
        Expanded(
        flex: 5,
          child: Text("Select Staff                        :", style: TextStyle(color: Colors.white,fontSize: 16)),
        ),
        Expanded(
          flex: 5,
          child: DropdownButtonFormField<String>(
            value: selectStaff,
            isExpanded: true,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "Select Staff",
              contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            items: staffNames.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.black)),
              );
            }).toList(),
            onChanged: (value){
              setState(() {
                selectStaff = value;
              });
            },
          ),
        ),
        ],
            ),
            SizedBox(height: 20,),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey.shade900,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(width: 2, color: Colors.white),
                  ),
                ),
                onPressed: () async {
                  if (selectStaff != null) {
                    Navigator.pop(context, selectStaff);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please select a staff")),
                    );
                  }
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsScreen()));
                },
                child: const Text('SUBMIT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
