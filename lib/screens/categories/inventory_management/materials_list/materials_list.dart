import 'package:flutter/material.dart';

class MaterialsList extends StatefulWidget {
  const MaterialsList({super.key});

  @override
  State<MaterialsList> createState() => _MaterialsListState();
}

class _MaterialsListState extends State<MaterialsList> {
  TextEditingController nameController = TextEditingController();
List<String> materials = [];
  void editBox(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.indigo.shade900,width: 2)),
                backgroundColor: Colors.white,
                foregroundColor: Colors.indigo.shade900,
              ),
              onPressed: () {
                Navigator.pop(context);
                showEditDialog(index);
              },
              child: Text("EDIT", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.indigo.shade900,width: 2)),
                backgroundColor: Colors.white,
                foregroundColor: Colors.indigo.shade900,
              ),
              onPressed: () {
                setState(() {
                  materials.removeAt(index);
                });
                Navigator.pop(context);
                msgDeleteBox();
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
    TextEditingController(text: materials[index]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: Colors.indigo.shade900,
        content:Row(
            children: [
              Expanded(child: Text("Material Name  :",style: TextStyle(fontSize: 17,color: Colors.white),)),
              Expanded(child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Material name",
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
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: Colors.white, width: 2)),
              backgroundColor: Colors.indigo.shade900,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
            child: Text("CANCEL"),
          ),SizedBox(width: 15,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: Colors.white, width: 2)),
              backgroundColor: Colors.indigo.shade900,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              setState(() {
                materials[index] = controller.text.trim();
              });
              Navigator.pop(context);
            },
            child: Text("UPDATE"),
          ),
        ],
      ),
    );
  }
  void msgBox() {
    showDialog(context: context, builder: (context) =>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
          ),
          title: Text("Message"),
          content: Text(
              "Material Inserted Successfully"),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // close createMaterial dialog
              nameController.clear();
              setState(() {});
            },
                child: Text(
                  "OK", style: TextStyle(color: Colors.indigo.shade900),))
          ],
        ));
  }
  void msgDeleteBox() {
    showDialog(context: context, builder: (context) =>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
          ),
          title: Text("Message"),
          content: Text(
              "Material Deleted Successfully"),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // close createMaterial dialog
              nameController.clear();
              setState(() {});
            },
                child: Text(
                  "OK", style: TextStyle(color: Colors.indigo.shade900),))
          ],
        ));
  }

  void createMaterial(){
    showDialog(context: context, builder: (context)=>
    AlertDialog(backgroundColor: Colors.green.shade900,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: Column(mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15,),
        Row(
        children: [
          Expanded(flex: 5,
            child: Text(
              "Material Name    :",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Expanded(flex: 5,
            child: TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,hintText: "Material Name",hintStyle: TextStyle(color: Colors.grey,fontSize: 16),
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(color: Colors.white, width: 2),
                  ),
                  backgroundColor: Colors.green.shade900,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("CANCEL"),
              ),ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(color: Colors.white, width: 2),
                  ),
                  backgroundColor: Colors.green.shade900,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  if(nameController.text.isNotEmpty){
                    setState(() {
                      materials.add(nameController.text);
                    });
    msgBox();
    }else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please give Materials Name")));
    }
                },
                child: const Text("SUBMIT")
              ),
            ],
          )
        ],
      ),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 10),
          Expanded(
            child: materials.isEmpty
                ? const Center(
              child: Text(
                "",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
                : ListView.separated(
              itemCount: materials.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: (){
                    editBox(index);
                  },
                    title: Text(
                      materials[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                );
              }, separatorBuilder: (context,index) => Divider(height: 10,thickness: 1,color: Colors.white,),
            ),
          ),
        Center(
          child: ElevatedButton(
          style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey.shade900,
          foregroundColor: Colors.white,
          side: BorderSide(color: Colors.white,width: 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
              ),
              onPressed: (){
               createMaterial();
              }, child: Text("CREATE MATERIALS")
          ),
        ),
          SizedBox(height: 20,)
      ]
      ),
    );
  }
}
