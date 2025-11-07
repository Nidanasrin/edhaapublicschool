//import 'dart:typed_data';
import 'package:flutter/material.dart';

import '../details/tags_details.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// //import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:permission_handler/permission_handler.dart';

class TagsPremium extends StatefulWidget {
  const TagsPremium({super.key});

  @override
  State<TagsPremium> createState() => _TagsPremiumState();
}

class _TagsPremiumState extends State<TagsPremium> {
  // Future<void> downloadImage()async{
  //   var status = await Permission.storage.request();
  //   if(!status.isGranted){
  //     Fluttertoast.showToast(msg: "Permission Denied.",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
  //     return;
  //   }
  //   try{
  //     final ByteData bytes = await rootBundle.load('assets/images/idcard.webp');
  //     final Uint8List list = bytes.buffer.asUint8List();
  //     final result = await ImageGallerySaver.saveImage(list, name: 'idcard');
  //     if(result['isSuccess'] == true){
  //       Fluttertoast.showToast(msg: "Image saved to Gallery.",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
  //     }else{
  //       Fluttertoast.showToast(msg: "Failed to save Image.",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
  //     }
  //   }catch(e){
  //     Fluttertoast.showToast(msg: "Error : $e",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
  //
  //   }
  // }
  List<Map<String, dynamic>> tagspremium = List.generate(35, (index) {
    return {
      'image': 'assets/images/tag.webp',
      'title': 'Design-${index + 1}',
      'rating': 5.0,
      'days': 'Delivery in 14 days',
      'rate': 70,
    };
  });

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
    itemCount: tagspremium.length,
    itemBuilder: (context, index) {
    final item = tagspremium[index];
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
