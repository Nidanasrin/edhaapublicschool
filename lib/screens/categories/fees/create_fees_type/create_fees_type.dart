import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/fees/create_fees_type/feetypes_screen.dart';

class CreateFeesType extends StatefulWidget {
  const CreateFeesType({super.key});

  @override
  State<CreateFeesType> createState() => _CreateFeesTypeState();
}

class _CreateFeesTypeState extends State<CreateFeesType> {
  List<String> list = [
    "SCHOOL FEE",
    "DEVELOPMENT FEE",
    "BOOK FEE",
    "UNIFORM FEE",
  ];

  /// Show Edit/Delete dialog
  void editbox(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.indigo.shade900)),
                backgroundColor: Colors.white,
                foregroundColor: Colors.indigo.shade900,
              ),
              onPressed: () {
                Navigator.pop(context);
                showEditDialog(index);
              },
              child: Text("EDIT", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.indigo.shade900)),
                backgroundColor: Colors.white,
                foregroundColor: Colors.indigo.shade900,
              ),
              onPressed: () {
                setState(() {
                  list.removeAt(index);
                });
                Navigator.pop(context);
              },
              child:
              Text("DELETE", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  /// Edit Fee Type name
  void showEditDialog(int index) {
    TextEditingController controller =
    TextEditingController(text: list[index]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.indigo.shade900,
        content:Row(
          children: [
            Expanded(child: Text("Fees Name  :",style: TextStyle(fontSize: 17,color: Colors.white),)),
            Expanded(child: TextField(
          controller: controller,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "Enter new name",
            border: OutlineInputBorder(),
          ),
            ),
            )
        ]
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.white, width: 2)),
              backgroundColor: Colors.indigo.shade900,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
            child: Text("CANCEL"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.white, width: 2)),
              backgroundColor: Colors.indigo.shade900,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              setState(() {
                list[index] = controller.text.trim();
              });
              Navigator.pop(context);
            },
            child: Text("SAVE"),
          ),
        ],
      ),
    );
  }

  /// Add new Fee Type
  void showAddDialog() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create Fee Type"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Enter fee type",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("CANCEL"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  list.add(controller.text.trim());
                });
              }
              Navigator.pop(context);
            },
            child: Text("ADD"),
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => editbox(index),
                    title: Text(
                      list[index],
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    Divider(thickness: 1, height: 10, color: Colors.white30),
              ),
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.white, width: 2)),
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> EnterFeesTypesScreen()));

                },
                child: Text("CREATE FEES TYPE"),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
