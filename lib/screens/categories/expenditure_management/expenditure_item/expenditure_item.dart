import 'package:flutter/material.dart';

class ExpenditureItem extends StatefulWidget {
  const ExpenditureItem({super.key});

  @override
  State<ExpenditureItem> createState() => _ExpenditureItemState();
}

class _ExpenditureItemState extends State<ExpenditureItem> {
TextEditingController itemNameController = TextEditingController();

void msgbox(){
  showDialog(context: context, builder: (context)=>
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        title: Text("Message"),
        content: Text("Expenditure Item Created Successfully"),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
        ],
      )
  );
}

  void expenditureItem(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          backgroundColor: Colors.green.shade900,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          content: Column(mainAxisSize: MainAxisSize.min,
            children: [
          Row(
          children: [
          Expanded(
          flex: 4,
            child: Text(
              "Expenditure Item Name",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),),
          Expanded(
            flex: 5,
            child: TextField(
              controller: itemNameController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,hintText: "Expenditure Item Name",hintStyle: TextStyle(color: Colors.grey),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ),
          ],
        ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.white, width: 2),
                      ),
                      backgroundColor: Colors.green.shade900,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                     Navigator.pop(context);
                    },
                    child: const Text("CANCEL"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.white, width: 2),
                      ),
                      backgroundColor: Colors.green.shade900,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if(itemNameController.text.isNotEmpty) {
                        msgbox();
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please give Expenditure Item Name')));
                      }
                    },
                    child: const Text("SUBMIT"),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
               expenditureItem();              },
              child: const Text("CREATE EXPENDITURE ITEM"),
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),

    );
  }
}
