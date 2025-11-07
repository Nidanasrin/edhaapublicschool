import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/fees/fees_dues_sms/details_screen.dart';

class FeesDuesSmsDetails extends StatefulWidget {
  const FeesDuesSmsDetails({super.key});

  @override
  State<FeesDuesSmsDetails> createState() => _FeesDuesSmsDetailsState();
}

class _FeesDuesSmsDetailsState extends State<FeesDuesSmsDetails> {
  final List<Map<String, dynamic>> feelist = [
    {"Total Fees": "35000"},
    {"Paid": "25000"},
    {"Concession Amount": "6000"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // ✅ Scrollable section
            Expanded(
              child: ListView.builder(
                itemCount: feelist.length + 1, // +1 for Due Amount
                itemBuilder: (context, index) {
                  if (index == feelist.length) {
                    return Column(
                      children: const [
                        Divider(thickness: 2, height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Due Amount",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              ":   10000",
                              style: TextStyle(
                                color: Colors.lightGreenAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 30, thickness: 2),
                      ],
                    );
                  }

                  final item = feelist[index];
                  final title = item.keys.first;
                  final value = item.values.first.toString();
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: rowField(title, value),
                  );
                },
              ),
            ),

            // ✅ Fixed bottom section
            Column(
              children: [
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade900,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(width: 2, color: Colors.white),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsScreen()));
                  },
                  child: const Text('DETAILS'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/app_sms.png"),
                      radius: 20,
                    ),
                    SizedBox(width: 15),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/phone.png"),
                      radius: 20,
                    ),
                    SizedBox(width: 15),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/bell (1).png"),
                      radius: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget rowField(String title, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        ":   $value",
        style: const TextStyle(
          color: Colors.lightGreenAccent,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
