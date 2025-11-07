import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'package:raynottschool/screens/categories/marks/subject_creation/create_subject.dart';

class SubjectCreation extends StatefulWidget {
  const SubjectCreation({super.key});

  @override
  State<SubjectCreation> createState() => _SubjectCreationState();
}

class _SubjectCreationState extends State<SubjectCreation> {
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
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.indigo.shade900,width: 2)),
                backgroundColor: Colors.white,
                foregroundColor: Colors.indigo.shade900,
              ),
              onPressed: () {
                setState(() {
                  subjects.removeAt(index);
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
    TextEditingController(text: subjects[index]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.indigo.shade900,
        content:Row(
            children: [
              Expanded(child: Text("Subject Name  :",style: TextStyle(fontSize: 17,color: Colors.white),)),
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
                subjects[index] = controller.text.trim();
              });
              Navigator.pop(context);
            },
            child: Text("SAVE"),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(itemBuilder: (context,index){
              final sub = subjects[index];
              return ListTile(
                onTap: ()=> editbox(index),
                title: Text(sub,style: TextStyle(color: Colors.white,fontSize: 16),),
              );
            }, separatorBuilder: (context,index)=> Divider(height: 0,thickness: 0.5,), itemCount: subjects.length),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: ()async {
              final newSubjects = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateSubject()),
              );

              // Check if something was returned
              if (newSubjects != null && newSubjects is List<String>) {
                setState(() {
                  subjects.addAll(newSubjects); // Add to the list
                });
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              backgroundColor: Colors.blueGrey.shade900,
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.white, width: 2),
            ),
            child: const Text("CREATE SUBJECTS"),
          ),
          SizedBox(height: 30,),
        ],
      ),

    );
  }
}
