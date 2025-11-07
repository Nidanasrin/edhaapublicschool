import 'package:flutter/material.dart';

class StaffdetailsEdit extends StatefulWidget {
  const StaffdetailsEdit({super.key});

  @override
  State<StaffdetailsEdit> createState() => _StaffdetailsEditState();
}

class _StaffdetailsEditState extends State<StaffdetailsEdit> {
  // TextEditingControllers for editable fields
  final TextEditingController nameController =
  TextEditingController(text: "LAKSHMI");
  final TextEditingController fatherController =
  TextEditingController(text: "ASHOK NAIR");
  final TextEditingController designationController =
  TextEditingController(text: "TEACHER");
  final TextEditingController contactController =
  TextEditingController(text: "9752194076");
  final TextEditingController dobController =
  TextEditingController(text: "8th August 1997");
  final TextEditingController addressController = TextEditingController(
      text: "Kaveri block 5th cross Bettadasnapura Bengaluru 68");

  void saveDetails(){
    String updatedName = nameController.text;
    String updatedFather = fatherController.text;
    String updatedDesignation = designationController.text;
    String updatedContact = contactController.text;
    String updatedDOB = dobController.text;
    String updatedAddress = addressController.text;
    print("✅ Saved Details:");
    print("Name: $updatedName");
    print("Father: $updatedFather");
    print("Designation: $updatedDesignation");
    print("Contact: $updatedContact");
    print("DOB: $updatedDOB");
    print("Address: $updatedAddress");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Details Saved Successfully ✅',
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            // Non-editable ID
            buildNonEditableRow("Staff ID", " : 3073215"),
            const SizedBox(height: 15),

            // Editable fields
            buildEditableRow("Staff Name", nameController),
            const SizedBox(height: 15),
            buildEditableRow("Father Name", fatherController),
            const SizedBox(height: 15),
            buildEditableRow("Designation", designationController),
            const SizedBox(height: 15),
            buildEditableRow("Contact No", contactController),
            const SizedBox(height: 15),
            buildEditableRow("DOB", dobController),
            const SizedBox(height: 15),
            buildEditableRow("Address", addressController),
            const SizedBox(height: 15),

            // Photo
            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text(
                    "Photo",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: Container(
                    height: 120,
                    width: 180,
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Image.asset("assets/images/girl4.jpg"),
                  ),
                ),
              ],
            ),

            const Spacer(),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
saveDetails();
print("Edited Name: ${nameController.text}");
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    backgroundColor: Colors.blueGrey.shade900,
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                  ),
                  child: const Text("SAVE"),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    backgroundColor: Colors.blueGrey.shade900,
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                  ),
                  child: const Text("CANCEL"),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  // 🟩 Non-editable row (for Staff ID)
  Widget buildNonEditableRow(String title, String value) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child:
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 17))),
        Expanded(
            flex: 5,
            child:
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 17))),
      ],
    );
  }

  // 🟨 Editable row (for all other fields)
  Widget buildEditableRow(String title, TextEditingController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 3,
            child:
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 17))),
        Expanded(
          flex: 5,
          child: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Colors.blueGrey.shade800,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}
