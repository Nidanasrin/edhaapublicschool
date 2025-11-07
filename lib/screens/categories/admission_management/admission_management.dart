import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'package:raynottschool/screens/categories/admission_management/new_admission.dart';

class AdmissionManagement extends StatefulWidget {
  const AdmissionManagement({super.key});

  @override
  State<AdmissionManagement> createState() => _AdmissionManagementState();
}

class _AdmissionManagementState extends State<AdmissionManagement> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;
  List<Map<String, dynamic>> container = [
    {"color": Colors.blue, "text": 'Inquiry'},
    {"color": Colors.amber, "text": 'Pending'},
    {"color": Colors.green, "text": 'Approval'},
    {"color": Colors.red.shade700, "text": 'Rejected'},
  ];

  Future<void> pickDate(TextEditingController controller, bool isFrom) async {
    DateTime initalDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initalDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
        if (isFrom) {
          fromDate = pickedDate;
        } else {
          toDate = pickedDate;
        }
      });
    }
  }

  void calendarDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.indigo.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "From Date",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 5,
                  child: TextField(
                    onTap: () => pickDate(fromDateController, true),
                    controller: fromDateController,
                    readOnly: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today, color: Colors.white),
                        onPressed: () => pickDate(fromDateController, true),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'dd/MM/yyyy',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "To Date",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 5,
                  child: TextField(
                    onTap: () => pickDate(toDateController, false),
                    controller: toDateController,
                    readOnly: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today, color: Colors.white),
                        onPressed: () => pickDate(toDateController, false),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'dd/MM/yyyy',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white, width: 2),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("SUBMIT"),
            ),
          ],
        ),
      ),
    );
  }
  void msgbox(){
    showDialog(
        context: context, builder: (context)=>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text("Message"),
          content: Text("No New Admissions Found"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
          ],
        )
    );
  }

  @override
  void dispose() {
    fromDateController.dispose();
    toDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey.shade900,
        actions: [
          IconButton(
            onPressed: () {
              calendarDialog();
            },
            icon: Icon(Icons.calendar_month, color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Flexible(
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 3
                ),
                itemCount: container.length,
                itemBuilder: (context, index) {
                  final item = container[index];
                  return GestureDetector(
                    onTap: (){
                      msgbox();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: item['color'],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("0",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                            Text(item['text'],style: TextStyle(color: Colors.white,fontSize: 15),)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> NewAdmission()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple.shade900,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 25),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text("New Admission", style: TextStyle(color: Colors.white,fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
