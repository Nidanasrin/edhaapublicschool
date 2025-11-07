import 'package:flutter/material.dart';

class DataconfidentialityAgreement extends StatefulWidget {
  const DataconfidentialityAgreement({super.key});

  @override
  State<DataconfidentialityAgreement> createState() => _DataconfidentialityAgreementState();
}

class _DataconfidentialityAgreementState extends State<DataconfidentialityAgreement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Data Confidentiality Agreement",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0,top: 16.0,right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("THIS DATA CONFIDENTIALITY AGREEMENT (the agreement) BETWEEN",style: TextStyle(fontSize: 16),),
            SizedBox(height: 10.0,),
            Text("Student Unique Card India Pvt Ltd",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            SizedBox(height: 5.0,),
            Text("Level - 2,Oval iLabs,Hi-tech CityHyderabad, Telangana, India - 500081(Company)",style: TextStyle(fontSize: 16),),
            SizedBox(height: 15.0,),
            Text("AND",style: TextStyle(fontSize: 16),),
            SizedBox(height: 15.0,),
            Text("EDHAA PUBLIC SCHOOL",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text("No.45,Prabhakar reddy layout,Mylasandra,Bangalore,560068,Bangalore,Karnataka(Buyer)",style: TextStyle(fontSize: 16),),
            Spacer(),
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(width: 2,color: Colors.grey)),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: (){}, child: Text("NEXT",style: TextStyle(fontWeight: FontWeight.bold),)),
              ],
            ),
            SizedBox(height: 20.0,)
          ],
        ),
      ),
    );
  }
}
