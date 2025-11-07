import 'package:flutter/material.dart';

class DeleteClasswiseDetails extends StatefulWidget {
  const DeleteClasswiseDetails({super.key});

  @override
  State<DeleteClasswiseDetails> createState() => _DeleteClasswiseDetailsState();
}

class _DeleteClasswiseDetailsState extends State<DeleteClasswiseDetails> {
  List<Map<String,dynamic>> feeList =[
    {
      "type": "BOOK FEE",
      "amount" : 4500,
    },
    {
      "type": "UNIFORM FEE",
      "amount" : 2500,
    }, {
      "type": "SCHOOL FEE",
      "amount" : 45000,
    } ,{
      "type": "DEVELOPMENT FEE",
      "amount" : 2000,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: feeList.isEmpty
          ? Center(
        child: Text(
          "No Fees Found for this Organization",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      )
          : ListView.separated(
        itemCount: feeList.length,
        separatorBuilder: (context, index) => Divider(
          thickness: 1,
          height: 0,
          color: Colors.white24,
        ),
        itemBuilder: (context, index) {
          final item = feeList[index];
          return ListTile(
            contentPadding:
            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item["type"] ?? "Type",
                  style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  "Amount : ₹ ${item["amount"] ?? "0"}",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  feeList.removeAt(index);
                });
              },
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
