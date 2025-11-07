import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/shopping.dart';
import 'package:raynottschool/popupmenu_item/belts/belts_premium.dart';
import 'package:raynottschool/popupmenu_item/belts/belts_regular.dart';
import 'package:raynottschool/popupmenu_item/cub_codes.dart';
import 'package:raynottschool/popupmenu_item/face_Attendance/face_attendance.dart';
import 'package:raynottschool/popupmenu_item/kidfit.dart';
import 'package:raynottschool/popupmenu_item/registration.dart';
import 'package:raynottschool/popupmenu_item/smart_idcard.dart';
import 'package:raynottschool/popupmenu_item/sms.dart';
import 'package:raynottschool/popupmenu_item/tags/tags_premium.dart';
import 'package:raynottschool/popupmenu_item/tags/tags_regular.dart';
import 'package:raynottschool/popupmenu_item/ties/ties_premium.dart';
import 'package:raynottschool/popupmenu_item/ties/ties_regular.dart';

class Shopping extends StatefulWidget {
  @override
  State<Shopping> createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  TextEditingController searchController = TextEditingController();
  final List<Map<String, dynamic>> shopping = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: "Staff Name/Staff Code",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 5),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 2.6,
              ),
              itemCount: shoppingList.length,
              itemBuilder: (context, index) {
                final item = shoppingList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (item["title"] == "Tags_Regular") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Tags_Regular(),
                          ),
                        );
                      } else if (item["title"] == "Tags_Premium") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TagsPremium(),
                          ),
                        );
                      } else if (item["title"] == "Face Attendance") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FaceAttendance(),
                          ),
                        );
                      } else if (item["title"] == "Belts_Regular") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BeltsRegular(),
                          ),
                        );
                      } else if (item["title"] == "Belts_Premium") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BeltsPremium(),
                          ),
                        );
                      } else if (item["title"] == "Ties_Regular") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TiesRegular(),
                          ),
                        );
                      } else if (item["title"] == "Ties_Premium") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TiesPremium(),
                          ),
                        );
                      } else if (item["title"] == "Smart ID Card") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SmartIdcard(),
                          ),
                        );
                      } else if (item["title"] == "Registration") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Registration(),
                          ),
                        );
                      } else if (item["title"] == "SMS") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Sms(),
                          ),
                        );
                      } else if (item["title"] == "Kid Fit") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Kidfit(),
                          ),
                        );
                      } else if (item["title"] == "Cub Codes") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CubCoders(),
                          ),
                        );
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white,
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              height:
                                  100, // 👈 Increase this to make the image bigger
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image: AssetImage(item['image']),
                                  fit: BoxFit.cover, // fills the container
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item['title'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  Row(
                                    children: [
                                      Text(
                                        item['rating'].toString(),
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      SizedBox(width: 3),
                                      ...List.generate(
                                        5,
                                        (context) => Icon(
                                          Icons.star,
                                          color: Colors.pink,
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    item['days'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: Text(
                                "₹${item['rate'].toString()}",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 15,),
        ],
      ),
    );
  }
}
