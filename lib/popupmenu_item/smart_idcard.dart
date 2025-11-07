import 'package:flutter/material.dart';
import 'package:raynottschool/popupmenu_item/details/face_details.dart';

class SmartIdcard extends StatefulWidget {
  const SmartIdcard({super.key});

  @override
  State<SmartIdcard> createState() => _SmartIdcardState();
}

class _SmartIdcardState extends State<SmartIdcard> {
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> idcard = [
    {
      'image': 'assets/images/idcard.webp',
      'title': 'Smart ID Card',
      'rating': 5.0,
      'days': 'Delivery in 14 days',
      'rate': 50,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                hintText: "Staff Name / Staff Code",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // single column
                childAspectRatio: 2.6, // adjust height of each card
              ),
              itemCount: idcard.length,
              itemBuilder: (context, index) {
                final item = idcard[index];
                return Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: GestureDetector(
                    onTap: () {
                      // Example: Navigate to detail page
                       Navigator.push(context, MaterialPageRoute(builder: (context) => FaceDetails()));
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
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image: AssetImage(item['image']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item['title'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Text(
                                        item['rating'].toString(),
                                        style: const TextStyle(
                                            color: Colors.green),
                                      ),
                                      const SizedBox(width: 3),
                                      ...List.generate(
                                        5,
                                            (i) => Icon(
                                          Icons.star,
                                          color: i <
                                              item['rating']
                                                  .round() // pink for filled stars
                                              ? Colors.pink
                                              : Colors.grey,
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    item['days'],
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                "₹${item['rate']}",
                                style: const TextStyle(
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
        ],
      ),
    );
  }
}
