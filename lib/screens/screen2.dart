import 'package:flutter/material.dart';
import 'package:raynottschool/popupmenu_item/shopping.dart';
import 'package:raynottschool/screens/categories/achievements/achievements.dart';
import 'package:raynottschool/screens/categories/admission_management/admission_management.dart';
import 'package:raynottschool/screens/categories/alumni_details/alumni_details.dart';
import 'package:raynottschool/screens/categories/analytics/analytics.dart';
import 'package:raynottschool/screens/categories/appsms/appsms.dart';
import 'package:raynottschool/screens/categories/attendence/attendence_screen.dart';
import 'package:raynottschool/screens/categories/behaviour_management/behaviour_management.dart';
import 'package:raynottschool/screens/categories/calendar/calendar.dart';
import 'package:raynottschool/screens/categories/change_password/change_password.dart';
import 'package:raynottschool/screens/categories/create_classes/create_classes.dart';
import 'package:raynottschool/screens/categories/curriculum_trackers/curriculum_trackers.dart';
import 'package:raynottschool/screens/categories/documents/documents.dart';
import 'package:raynottschool/screens/categories/expenditure_management/expenditure_management.dart';
import 'package:raynottschool/screens/categories/fees/fees.dart';
import 'package:raynottschool/screens/categories/gallery/gallery.dart';
import 'package:raynottschool/screens/categories/homework/homework.dart';
import 'package:raynottschool/screens/categories/inventory_management/inventory_management.dart';
import 'package:raynottschool/screens/categories/leave_management/leave_management.dart';
import 'package:raynottschool/screens/categories/marks/marks.dart';
import 'package:raynottschool/screens/categories/organisation/organsiation_1.dart';
import 'package:raynottschool/screens/categories/ptm_management/ptm_management.dart';
import 'package:raynottschool/screens/categories/registration_status/registration_status.dart';
import 'package:raynottschool/screens/categories/remarks/remarks.dart';
import 'package:raynottschool/screens/categories/reviews/reviews.dart';
import 'package:raynottschool/screens/categories/staff_details/staff_details.dart';
import 'package:raynottschool/screens/categories/students_details/students_details.dart';
import 'package:raynottschool/screens/categories/students_registration/students_registration.dart';
import 'package:raynottschool/screens/categories/support_tickets/support_tickets.dart';
import 'package:raynottschool/screens/categories/todo_list/todo_list.dart';
import 'package:raynottschool/screens/categories/voicecall/voicecall.dart';
import 'package:raynottschool/screens/homepage.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final List<Map<String, dynamic>> menuItems = [
    {"image": "assets/images/organisation.png", "label": "Organization Details", "color": Colors.blueGrey},
    {"image": "assets/images/app_sms.png", "label": "App SMS", "color": Colors.orange},
    {"image": "assets/images/phone.png", "label": "SMS/Voice Calls", "color": Colors.green},
    {"image": "assets/images/attendence.png", "label": "Attendance", "color": Colors.purple},
    {"image": "assets/images/fees.png", "label": "Fees", "color": Colors.brown},
    {"image": "assets/images/homework.png", "label": "Home Work", "color": Colors.indigo},
    {"image": "assets/images/marks.png", "label": "Marks", "color": Colors.blue},
    {"image": "assets/images/behaviour.png", "label": "Behaviour Management", "color": Colors.teal},
    {"image": "assets/images/analysis (1).png", "label": "Analytics", "color": Colors.deepOrange},
    {"image": "assets/images/staff details.png", "label": "Staff Details", "color": Colors.red},
    {"image": "assets/images/studentdetails.png", "label": "Student Details", "color": Colors.blueGrey},
    {"image": "assets/images/studentregistration.png", "label": "Student Registration", "color": Colors.blue},
    {"image": "assets/images/reg_status.png", "label": "Registration Status", "color": Colors.green},
    {"image": "assets/images/reviews.png", "label": "Reviews", "color": Colors.lightBlue},
    {"image": "assets/images/remarks.png", "label": "Remarks", "color": Colors.red},
    {"image": "assets/images/achievements.png", "label": "Achievements", "color": Colors.amber},
    {"image": "assets/images/documents.png", "label": "Documents", "color": Colors.brown},
    {"image": "assets/images/calendar (1).png", "label": "Calendar", "color": Colors.purple},
    {"image": "assets/images/leave.png", "label": "Leave Management", "color": Colors.blue},
    {"image": "assets/images/ptm.png", "label": "PTM Management", "color": Colors.lightBlue},
    {"image": "assets/images/class (2).png", "label": "Create Class", "color": Colors.lightBlue},
    {"image": "assets/images/admission.png", "label": "Admission Management", "color": Colors.pink},
    {"image": "assets/images/support-ticket.png", "label": "Support Tickets", "color": Colors.lightBlue},
    {"image": "assets/images/curriculum (2).png", "label": "Curriculum Trackers", "color": Colors.cyan},
    {"image": "assets/images/expenditure.png", "label": "Expenditure Management", "color": Colors.green},
    {"image": "assets/images/alumni.png", "label": "Alumni Details", "color": Colors.orange},
    {"image": "assets/images/list.png", "label": "ToDo List", "color": Colors.redAccent},
    {"image": "assets/images/gallery.png", "label": "Gallery", "color": Colors.pinkAccent},
    {"image": "assets/images/inventory-management.png", "label": "Inventory Management", "color": Colors.brown},
    {"image": "assets/images/password.png", "label": "Change Password", "color": Colors.teal},
  ];
  void msgbox(BuildContext context) {
    showDialog(context: context, builder: (context) =>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
          ),
          title: Text("Message"),
          content: Text("No Information Available"),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context);
            },
                child: Text(
                  "Ok", style: TextStyle(color: Colors.indigo.shade900),))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: Colors.white,
        title: const Text("EDHAA PUBLIC SCHOOL",style: TextStyle(color: Colors.white,fontSize: 16),),
        backgroundColor: Colors.indigo.shade900,
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons., color: Colors.green),
          // ),
          PopupMenuButton<int>(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              onSelected: (value){
              if(value ==1){
Navigator.push(context, MaterialPageRoute(builder: (context)=> Shopping()));
              }else if(value == 2){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Homescreen()));
              }else if(value == 3){

              }
              },
              itemBuilder: (context)=> [
                PopupMenuItem(value: 1,
                  child: Icon(Icons.shopping_cart, color: Colors.orange),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Icon(Icons.home, color: Colors.blue),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Icon(Icons.pan_tool, color: Colors.pink),
                ),
              ])
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: menuItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return GestureDetector(
              onTap: () {
                if(item["label"]=="Organization Details") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => OrgansiationDetailsScreen1()));
                }
                else if(item["label"]=="App SMS") {
                Navigator.push(context, MaterialPageRoute(
                builder: (context) => Appsms()));
                }else if(item["label"]=="SMS/Voice Calls") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Voicecall()));
                }else if(item["label"]=="Attendance") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => AttendenceScreen()));
                }else if(item["label"]=="Fees") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Fees()));
                }else if(item["label"]=="Home Work") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Homework()));
                }else if(item["label"]=="Marks") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Marks()));
                }else if(item["label"]=="Behaviour Management") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => BehaviourManagement()));
                }else if(item["label"]=="Analytics") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Analytics()));
                }else if(item["label"]=="Staff Details") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => StaffDetails()));
                }else if(item["label"]=="Student Details") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => StudentsDetails()));
                }else if(item["label"]=="Student Registration") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => StudentsRegistration()));
                }else if(item["label"]=="Registration Status") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => RegistrationStatus()));
                }else if(item["label"]=="Reviews") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Reviews()));
                }else if(item["label"]=="Remarks") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Remarks()));
                }else if(item["label"]=="Achievements") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Achievements()));
                }else if(item["label"]=="Documents") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Documents()));
                }else if(item["label"]=="Leave Management") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => LeaveManagement()));
                }else if(item["label"]=="PTM Management") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => PtmManagement()));
                }else if(item["label"]=="Calendar") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Calendar()));
                }else if(item["label"]=="Create Class") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => CreateClasses()));
                }else if(item["label"]=="Admission Management") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => AdmissionManagement()));
                }else if(item["label"]=="Support Tickets") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SupportTickets()));
                }else if(item["label"]=="Curriculum Trackers") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => CurriculumTrackers()));
                }else if(item["label"]=="Expenditure Management") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ExpenditureManagement()));
                }else if(item["label"]=="Alumni Details") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => AlumniDetails()));
                }else if(item["label"]=="ToDo List") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => TodoList()));
                  msgbox(context);
                }else if(item["label"]=="Gallery") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Gallery()));
                }else if(item["label"]=="Inventory Management") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => InventoryManagement()));
                }else if(item["label"]=="Change Password") {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ChangePassword()));
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(item["image"],height: 40,width: 40,),

                  const SizedBox(height: 8),
                  Text(
                    item["label"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
