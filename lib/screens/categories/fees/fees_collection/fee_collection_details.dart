import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/fees/fees_collection/collect_fees.dart';
import 'package:raynottschool/screens/categories/fees/fees_collection/details.dart';

class FeeCollectionDetails extends StatefulWidget {
  const FeeCollectionDetails({super.key});

  @override
  State<FeeCollectionDetails> createState() => _FeeCollectionDetailsState();
}

class _FeeCollectionDetailsState extends State<FeeCollectionDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            buildRow(context,"Total Fees", "45000"),
            SizedBox(height: 15,),
            buildRow(context,"Concession", "12500"),
            SizedBox(height: 15,),
            buildRow(context,"Paid", "15000"),
            Divider(thickness: 1,height: 30,),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Due Amount",style: TextStyle(color: Colors.white,fontSize: 16),),
                    Text(": Rs 16396".toString(),style: TextStyle(color: Colors.white,fontSize: 16),),
                    ]
                ),
              ],
            ),
            Divider(thickness: 1,height: 30,),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    side: BorderSide(width: 2,color: Colors.white),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueGrey.shade900
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CollectFees()));
                }, child: Text("COLLECT FEES"))
              ],
            ),
      )
    );
  }
}
Widget buildRow(BuildContext context,String title,String value){
  return Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text(title,style: TextStyle(color: Colors.white,fontSize: 16),),
      Text(": Rs $value".toString(),style: TextStyle(color: Colors.white,fontSize: 16),),
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          side: BorderSide(width: 2,color: Colors.white),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueGrey.shade900
        ),
  onPressed: ()
  {
  // Navigate directly here
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Details()),
    );
  });
  }, child: Text("DETAILS"),
  )
  ]
  );
}
