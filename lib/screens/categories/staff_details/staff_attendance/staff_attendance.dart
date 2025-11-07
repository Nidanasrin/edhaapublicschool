import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';

class StaffAttendance extends StatefulWidget {
  const StaffAttendance({super.key});

  @override
  State<StaffAttendance> createState() => _StaffAttendanceState();
}

class _StaffAttendanceState extends State<StaffAttendance> {

  List<bool> selectedList = [];
  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    selectedList = List.generate(staffNames.length, (index)=> false);
  }

  void toggleSelectAll(){
    setState(() {
      selectAll = !selectAll;
      for(int i = 0;i < selectedList.length; i ++){
        selectedList[i] = selectAll;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey.shade900,
        title:
        Text("Note*. Please Tick the Staff Absentees",style: TextStyle(color: Colors.red,fontSize: 14),),
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        children: [
          Row(
            children: [
              Checkbox(value: selectAll, onChanged: (value){
                toggleSelectAll();
              },
                checkColor: Colors.grey,
                activeColor: Colors.green,
              ) ,               SizedBox(width: 5,),
              Text("Staff Names",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
            ],
          ),
          SizedBox(height: 10,),
          Expanded(child:
          ListView.separated(itemBuilder: (context,index){
        final name = staffNames[index];
        return ListTile(
leading: Checkbox(
  value: selectedList[index],
  onChanged: (value) {
    setState(() {
      selectedList[index] = value!;
      // Uncheck "select all" if any item is unchecked
      if (!value) {
        selectAll = false;
      } else if (selectedList.every((e) => e)) {
        selectAll = true;
      }
    });
  },
  checkColor: Colors.white,
  activeColor: Colors.green,
),
          title: Text(name,style: TextStyle(color: Colors.white,fontSize: 16),),
        );
      }, separatorBuilder: (context,index)=> Divider(thickness: 1,height: 0,), itemCount: staffNames.length),
    ),

          ElevatedButton(
            onPressed: ()async {
              if(selectedList.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please select at least one staff")),
                );
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(backgroundColor: Colors.green,
                      content: Text("Staff Attendance Submitted Successfully")),
                );
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
            child: const Text("SUBMIT"),
          ),
          SizedBox(height: 15,),
    ]
      )
    );
  }
}
