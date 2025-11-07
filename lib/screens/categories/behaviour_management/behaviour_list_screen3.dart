import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BehaviourListScreen3 extends StatefulWidget {
  const BehaviourListScreen3({super.key});

  @override
  State<BehaviourListScreen3> createState() => _BehaviourListScreen3State();
}

class _BehaviourListScreen3State extends State<BehaviourListScreen3> {
  List<double> ratings = [];

  @override
  void initState() {
    super.initState();
    ratings = List.filled(lists.length, 0.0);
  }

  void submitRatings() {
    for (int i = 0; i < lists.length; i++) {
      debugPrint("${lists[i]['title']}: ${ratings[i]} stars");
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Ratings submitted successfully!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  void msgBox(){
    showDialog(context: context, builder: (context)=>
    AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title:Text("Message",style: TextStyle(fontWeight: FontWeight.bold),),
        content: Text("Student Assessment Details Submitted Successfully"),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
      ],
    ));
  }
  List<Map<String, dynamic>> lists = [
    {
      "title": "Class Participation",
      "msg":
          "Measures how actively the student engages in class discussions and activities",
    },
    {
      "title": "Listening Skills",
      "msg":
          "Assesses the students ability to listen attentively and follow instructions",
    },
    {
      "title": "Respect for Others",
      "msg":
          "Evaluates the students behaviour towards classmates,teachers and staff,including politeness and...",
    },
    {
      "title": "Responsibility",
      "msg":
          "Observes the students ability to complete assignments on time and manage their belongings",
    },
    {
      "title": "Attention Span",
      "msg":
          "Looks at how well the students maintains focus during lessons and activities without getting easil...",
    },
    {
      "title": "Conflict Resolution Skills",
      "msg":
          "Assesses the students approach to handling conflicts with peers,focusing on their ability to seek p...",
    },
    {
      "title": "Self_Motivation",
      "msg":
          "Evaluates the students enthusiasm and independence in starting and completing tasks.",
    },
    {
      "title": "Emotional Regulation",
      "msg":
          "Measures how well the students manages their emotions, particularly in challenging situations... ",
    },
    {
      "title": "Respect for Classroom Rules",
      "msg":
          "Observes the students ability to follow school and classroom rules consistently.",
    },
    {
      "title": "Collaboration and Teamwork",
      "msg":
          "Assesses the students willingness and ability to work effectively in group settings",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final item = lists[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            item["title"],
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(width: 5),
                          Tooltip(
                            message: item["msg"],
                            textStyle: const TextStyle(color: Colors.white),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade500.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RatingBar.builder(
                            initialRating: ratings[index],
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(
                              horizontal: 3.0,
                            ),
                            itemBuilder: (context, _) =>
                                const Icon(Icons.star, color: Colors.amber),
                            unratedColor: Colors.white24,
                            onRatingUpdate: (rating) {
                              setState(() {
                                ratings[index] = rating;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) =>
                    Divider(thickness: 1, height: 10),
                itemCount: lists.length,
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (ratings.contains(0.0)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red.shade900,
                          content: Text("Please Submit all Assessments",style: TextStyle(color: Colors.white),)),
                    );
                  }else{
                    msgBox();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(color: Colors.white),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "SUBMIT",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
