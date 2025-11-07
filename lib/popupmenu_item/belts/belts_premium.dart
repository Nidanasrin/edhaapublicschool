import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/shopping.dart';
import 'package:raynottschool/popupmenu_item/details/tags_details.dart';

class BeltsPremium extends StatefulWidget {
  const BeltsPremium({super.key});

  @override
  State<BeltsPremium> createState() => _BeltsPremiumState();
}

class _BeltsPremiumState extends State<BeltsPremium> {
  TextEditingController searchController = TextEditingController();

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
              itemCount: beltsPremium.length,
              itemBuilder: (context, index) {
                final item = beltsPremium[index];
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                              builder: (context) => tags_details()));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.white,
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        child:  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              children: [
                                Container(
                                  height: 100, // 👈 Increase this to make the image bigger
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
                                      SizedBox(width: 30,),
                                      Row(
                                        children: [
                                          Text(
                                            item['rating'].toString(),
                                            style: TextStyle(color: Colors.green),
                                          ),
                                          SizedBox(width: 3),
                                          ...List.generate(
                                            5,
                                                (context) => Icon(Icons.star, color: Colors.pink, size: 18),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        item['days'],
                                        style: TextStyle(color: Colors.black, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Text(
                                    "₹${item['rate'].toString()}",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ),
                    )
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
