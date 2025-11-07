import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/students_details/edit_sudentDetails.dart';

class StudentsDetails3 extends StatefulWidget {
final String studentName;
final String selectedClass;

  const StudentsDetails3({super.key, required this.studentName, required this.selectedClass});
  @override
  State<StudentsDetails3> createState() => _StudentsDetails3State();
}

class _StudentsDetails3State extends State<StudentsDetails3> {
  late String studentName;
  late String fatherName;
  late String dob;
  late String contact;
  late String address;

  @override
  void initState() {
    super.initState();
    studentName = widget.studentName;
    fatherName = "AAKASH MENON";
    dob = "12th Sep 2020";
    contact = "9363520370";
    address =
    "96, CHARBHUJYA NIVAS, 1ST MAIN, 8TH CROSS GANGA BLOCK BETTADASANAPURA BANGALORE";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            rowField("Student Name", widget.studentName),
            SizedBox(height: 15,),
            rowField("Class Name", widget.selectedClass),
            SizedBox(height: 15,),
            rowField("Father Name", "AAKASH MENON"),
            SizedBox(height: 15,),
            rowField("DOB", "12th Sep 2020"),
            SizedBox(height: 15,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: rowField("Contact no", "9363520370")),
                IconButton(onPressed: (){}, icon: Icon(Icons.call,color: Colors.green,))
              ],
            ),
            SizedBox(height: 15,),
            rowField("Address", "96,CHARBHUJYA NIVAS,1ST MAIN,8TH CROSS GANGA BLOCK BETTADASANAPURA BANGALORE"),
            SizedBox(height: 15,),
        Row(
          children: [
            Expanded(
              flex: 0,
              child: Text(
                "Photo",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Expanded(
                flex: 10,
                child: Container(height: 100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: Image.asset("assets/images/girl4.jpg"),)
            ),
          ],
        ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.blueGrey.shade900,
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white, width: 2),
              ),
              child: const Text("DOWNLOAD QR CODE"),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> EditStudentDetails(selectedClass: widget.selectedClass, selectedStudent: widget.studentName)));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: Colors.blueGrey.shade900,
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white, width: 2),
                  ),
                  child: const Text("EDIT"),
                ),SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () async {
                    bool? confirmDelete = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Confirm Delete"),
                        content: Text("Are you sure you want to delete ${widget.studentName}?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text("Delete", style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );

                    if (confirmDelete != null && confirmDelete) {
                      // TODO: Add your deletion logic here
                      // Example: call your API or remove from local list
                      // await deleteStudent(widget.studentName, widget.selectedClass);

                      // Show a success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${widget.studentName} deleted successfully")),
                      );

                      // Optionally, navigate back after deletion
                      Navigator.pop(context);
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
                  child: const Text("DELETE"),
                ),SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: Colors.blueGrey.shade900,
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white, width: 2),
                  ),
                  child: const Text("DROP OUT"),
                ),
              ],
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
Widget rowField(
    String title,
    String value) {
  return Row(
    children: [
      Expanded(
        flex: 1,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      Expanded(
        flex: 3,
        child: Text(":  $value",style: TextStyle(color: Colors.white,fontSize: 16),)
      ),
    ],
  );
}
