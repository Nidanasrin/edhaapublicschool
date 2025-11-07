import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';
import 'package:raynottschool/screens/categories/reviews/view_reviews/add2.dart';
import 'package:raynottschool/screens/categories/reviews/view_reviews/view_reviews.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Row(
        children: [
        Expanded(
        flex: 4,
            child: Text("Class Name :", style: TextStyle(color: Colors.white, fontSize: 18))),
        SizedBox(width: 10),
        Expanded(
          flex: 5,
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            isExpanded: true,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
            items: list
                .map((e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e, style: TextStyle(color: Colors.black)),
            ))
                .toList(),
            onChanged: (value){
              selectedValue = value;
            },
          ),
        ),
        ],
      ),
            SizedBox(height: 20,),
            Center(
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   ElevatedButton(
                  onPressed: () {
                  if(selectedValue ==null ){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select class")));
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewReviews(selectedStudent: selectedValue!)));
                  },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade900,
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("VIEW REVIEWS", style: TextStyle(color: Colors.white)),
                  ),
                      SizedBox(width: 20,) ,
                  ElevatedButton(
                  onPressed: () {
                  if(selectedValue ==null ){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select class")));
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Add2(selectedStudent: selectedValue!, selectedClass: selectedValue!,)));

                  },
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey.shade900,
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("ADD REVIEWS", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
