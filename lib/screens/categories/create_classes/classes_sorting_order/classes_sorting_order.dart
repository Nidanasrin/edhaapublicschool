import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';

class ClassesSortingOrder extends StatefulWidget {
  const ClassesSortingOrder({super.key});

  @override
  State<ClassesSortingOrder> createState() => _ClassesSortingOrderState();
}

class _ClassesSortingOrderState extends State<ClassesSortingOrder> {
  final Map<String,TextEditingController> controller = {};
  late final List<String> _safeList;

  @override
  void initState() {
    super.initState();
    // initialize text controllers for each class
    _safeList = list.where((item) => item != null).cast<String>().toList();
    for (var item in list) {
      controller[item] = TextEditingController();
    }
  }
@override
  void dispose() {
    // dispose all controllers to prevent memory leaks
    for (var c in controller.values) {
      c.dispose();
    }
    super.dispose();
  }
  void msgBox(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text("Message"),
          content: Text("Please Enter Atleast One Roll Id Details"),
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
          content: Text("Classes with Roll Id Details Updated Successfully"),
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
      body: SafeArea(
        child:list.isEmpty
            ? const Center(
          child: Text(
            'No students found',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        )
            : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(itemBuilder: (context,index){
                           final item = list[index];
                           return ListTile(
                             contentPadding: const EdgeInsets.symmetric(
                                 horizontal: 8, vertical: 4),
                        title: Text(item,style: TextStyle(color: Colors.white,fontSize: 16),),
                      trailing:  SizedBox(width: 150,
                        child: TextField(
                        controller: controller[item]!,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                        filled: true,
                        hintText: "Roll Id",
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        ),
                        ),
                        ),
                      ),
                      );
                      }, separatorBuilder: (_,_)=> Divider(height: 0,thickness: 1,color: Colors.white,), itemCount: list.length),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey.shade900,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 2, color: Colors.white),
                  ),
                ),
                onPressed: () {
                  bool hasInput = controller.values.any((c)=> c.text.trim().isNotEmpty);
                  if(!hasInput){
                   msgBox();
                  }else{
                   msgBox2();
                  }

                },
                child: const Text(
                  'UPDATE',
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
