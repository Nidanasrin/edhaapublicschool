import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EnterFeesTypesScreen extends StatefulWidget {
  const EnterFeesTypesScreen({super.key});

  @override
  State<EnterFeesTypesScreen> createState() => _EnterFeesTypesScreenState();
}

class _EnterFeesTypesScreenState extends State<EnterFeesTypesScreen> {
  List<TextEditingController> controllers = [];

  /// Add a new empty field
  void addField() {
    setState(() {
      controllers.add(TextEditingController());
    });
  }

  /// Collect values from all fields
  void submit()async {
    List<String> feeTypes = controllers
        .map((c) => c.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    // for now just print
    print("Submitted Fees: $feeTypes");
    // if(feeTypes.isEmpty){
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter at least one fees type')));
    //   return;
    // }try{
    //   await FirebaseFirestore.instance
    //       .collection('Fees')
    //       .doc('create_fees_type')
    //       .collection('')
    // }

    Navigator.pop(context, feeTypes); // send list back if needed
  }

  @override
  void initState() {
    super.initState();
    controllers = []; // start empty
    addField(); // add first empty field by default
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1A2B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E1A2B),
        title: const Text("ENTER FEES TYPES",
            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: controllers[index],
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Enter Fees Type name",
                        hintStyle: const TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          const BorderSide(color: Colors.blue, width: 2),
                        ),
                        suffixIcon: index > 0
                            ? IconButton(
                          icon: const Icon(Icons.remove_circle,
                              color: Colors.red),
                          onPressed: () {
                            setState(() {
                              controllers.removeAt(index);
                            });
                          },
                        )
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: addField,
              child: Row(
                children: const [
                  Icon(Icons.add_circle, color: Colors.blue),
                  SizedBox(width: 6),
                  Text("ADD FEES TYPES",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white),
              ),
              onPressed: submit,
              child: const Text("SUBMIT"),
            ),
          ],
        ),
      ),
    );
  }
}
