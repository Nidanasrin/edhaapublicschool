import 'package:flutter/material.dart';

class Studentslistpage extends StatefulWidget {
  final String className;
  final List<String> students;

  const Studentslistpage({super.key, required this.className, required this.students});

  @override
  State<Studentslistpage> createState() => _StudentslistpageState();
}

class _StudentslistpageState extends State<Studentslistpage> {
  late List <TextEditingController> controller;

  @override
  void initState(){
    super.initState();
    controller = List.generate(widget.students.length, (index)=>
    TextEditingController(text: "${index +1}"));
  }

  @override
  void dispose(){
    for(var c in controller) {
      c.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueGrey.shade900,
      body: Column(
          children: [
            widget.students.isEmpty
                ? Center(child: Text("No Students Found"),)
                : Expanded(
                  child: ListView.separated(itemBuilder: (context,index){
                    final stdnt = widget.students[index];
                    return ListTile(
                      title: Text(stdnt,style: TextStyle(color: Colors.white),),
                      trailing: SizedBox(width: 100,height: 40,
                        child: TextField(
                          controller: controller[index],
                          decoration: InputDecoration(
                            fillColor: Colors.white,filled: true,border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
                          ),
                        ),
                      ),
                    );
                              }, separatorBuilder: (context,index)=>
                  Divider(thickness: 0.4,indent: 0,endIndent: 0,height: 0,), itemCount: widget.students.length),
                ),
    Center(
    child:
    ElevatedButton(style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(side: BorderSide(width: 2,color: Colors.white),borderRadius: BorderRadius.circular(10))
    ),
    onPressed: (){}, child: Text("SUBMIT")),
    ),
            SizedBox(height: 20.0,),
          ],
        ),
    );
  }
}
