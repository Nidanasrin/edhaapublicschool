import 'package:flutter/material.dart';

class DeleteOrgWiseDetails extends StatefulWidget {
  final List<Map<String, dynamic>> feeDetails;

  const DeleteOrgWiseDetails({super.key, required this.feeDetails});

  @override
  State<DeleteOrgWiseDetails> createState() => _DeleteOrgWiseDetailsState();
}

class _DeleteOrgWiseDetailsState extends State<DeleteOrgWiseDetails> {
   List<Map<String, dynamic>> _feeDetails = [];

   @override
  void initState() {
    super.initState();
    _feeDetails = List.from(widget.feeDetails);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: _feeDetails.isEmpty
          ? Center(
        child: Text(
          "No Fees Found for this Organization",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      )
          : ListView.separated(
        itemCount: _feeDetails.length,
        separatorBuilder: (context, index) => Divider(
          thickness: 1,
          height: 0,
          color: Colors.white24,
        ),
        itemBuilder: (context, index) {
          final item = _feeDetails[index];
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
                  _feeDetails.removeAt(index);
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
