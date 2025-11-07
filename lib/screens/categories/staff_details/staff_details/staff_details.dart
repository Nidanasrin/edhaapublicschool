import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'package:raynottschool/screens/categories/staff_details/staff_details/newstaff_registration.dart';
import 'package:raynottschool/screens/categories/staff_details/staff_details/staffdetailscreen.dart';

class StaffDetailscat extends StatefulWidget {
final List<String> selectedStaff;

  const StaffDetailscat({super.key, required this.selectedStaff});
  @override
  State<StaffDetailscat> createState() => _StaffDetailscatState();
}

class _StaffDetailscatState extends State<StaffDetailscat> {
  TextEditingController searchController = TextEditingController();
  List<String> filteredStaff = [];

  @override
  void initState() {
    super.initState();
    filteredStaff = List.from(staffNames);
  }
  void searchStaff(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredStaff = List.from(staffNames);
      } else {
        filteredStaff = staffNames.where((name) {
          final index = staffNames.indexOf(name);
          final code = staffCode[index];
          return name.toLowerCase().contains(query.toLowerCase()) ||
              code.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  List<String> staffCode = [
    "3073212",
    "3073213",
    "3073214",
    "3073215",
    "3073216",
    "3073217",
    "3073218",
    "3073210",
  ];
  List<String> designation = [
    "Admin",
    "ADMINISTRATION",
    "TEACHER",
    "TEACHER",
    "ASST TEACHER",
    "CLERK",
    "SUPPORT STAFF",
    "SUPPORT STAFF",
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.blueGrey.shade900,
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 35,),
            Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: TextField(
            controller: searchController,
            onChanged: searchStaff,
            decoration: InputDecoration(
              hintText: "Staff Name/Staff Code",
              hintStyle: TextStyle(color: Colors.grey),
              fillColor: Colors.white,
              filled: true,
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: () {
                  searchController.clear();
                  searchStaff('');
                },
                icon: Icon(Icons.close),
              ),
            ),
          ),
        ),
            Expanded(
              child: ListView.separated(itemBuilder: (context,index){
                final staff = staffNames[index];
                final code = staffCode[index];
                final design = designation[index];
                return ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Staffdetailscreen(staffIndex: index,)));
                  },
                  title: Text("$staff ($code)",style: TextStyle(color: Colors.white,fontSize: 16),),
                  subtitle: Text("Designation : $design",style: TextStyle(color: Colors.white,fontSize: 16),),
                  trailing: Column(
                    children: [
                      Icon(Icons.call,color: Colors.green,)
                    ],
                  ),
                );
              }, separatorBuilder: (context,index)=> Divider(thickness: 1,height: 10,), itemCount: filteredStaff.length),
            ),
            ElevatedButton(
              onPressed: ()async {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> StaffRegistrationForm()));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.blueGrey.shade900,
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white, width: 2),
              ),
              child: const Text("NEW STAFF REGISTRATION"),
            ),
            SizedBox(height: 15,),
              ]
        ),
      )
    );
  }
}
