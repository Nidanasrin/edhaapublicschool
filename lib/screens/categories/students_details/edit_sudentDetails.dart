import 'package:flutter/material.dart';

class EditStudentDetails extends StatefulWidget {
  final String selectedClass;
  final String selectedStudent;

  const EditStudentDetails({
    super.key,
    required this.selectedClass,
    required this.selectedStudent,
  });

  @override
  State<EditStudentDetails> createState() => _EditStudentDetailsState();
}

class _EditStudentDetailsState extends State<EditStudentDetails> {
  final TextEditingController nameInitialController = TextEditingController();
  final TextEditingController studentNameController = TextEditingController();
  final TextEditingController fatherNameController =
  TextEditingController(text: "S. AMARANATHA REDDY");
  final TextEditingController dayController = TextEditingController(text: "10");
  final TextEditingController monthController = TextEditingController(text: "8");
  final TextEditingController yearController = TextEditingController(text: "2021");
  final TextEditingController mobileController =
  TextEditingController(text: "9036530621");
  final TextEditingController addressController = TextEditingController(
      text:
      "#96, CHARBHUJYA NIVAS, 1ST MAIN, 8TH CROSS GANGA BLOCK BETTADASANAPURA, BANGALORE");

  @override
  void initState() {
    super.initState();
    studentNameController.text = widget.selectedStudent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: const Text(
                      "Student Name :",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: nameInitialController,
                      decoration: _inputDecoration("Initial"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: studentNameController,
                      decoration: _inputDecoration("Full Name"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              _buildLabelValueRow("Class Name", widget.selectedClass),
              const SizedBox(height: 15),

              _buildLabelAndField("Father Name", fatherNameController),
              const SizedBox(height: 15),

              Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text("DOB :", style: TextStyle(color: Colors.white)),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        _dobBox(dayController),
                        const SizedBox(width: 5),
                        _dobBox(monthController),
                        const SizedBox(width: 5),
                        _dobBox(yearController),
                        const SizedBox(width: 10),
                        const Icon(Icons.calendar_month, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              _buildLabelAndField("Contact No", mobileController),
              const SizedBox(height: 15),

              _buildLabelAndField("Address", addressController, maxLines: 3),
              const SizedBox(height: 15),

              Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text("Photo :", style: TextStyle(color: Colors.white)),
                  ),
                  Expanded(
                    flex: 4,
                    child:  ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/images/girl4.jpg",
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 30),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  ),
                  onPressed: () {
                    final updatedData = {
                      "name": studentNameController.text,
                      "fatherName": fatherNameController.text,
                      "dob":
                      "${dayController.text}-${monthController.text}-${yearController.text}",
                      "contact": mobileController.text,
                      "address": addressController.text,
                    };

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Student details updated successfully!"),
                      ),
                    );

                    // Wait briefly then go back
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pop(context, updatedData);
                    });
                  },
                  child: const Text(
                    "UPDATE",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  Widget _buildLabelAndField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text("$label :", style: const TextStyle(color: Colors.white)),
        ),
        Expanded(
          flex: 4,
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: _inputDecoration(""),
          ),
        ),
      ],
    );
  }

  Widget _buildLabelValueRow(String label, String value) {
    return Row(
      children: [
        Text("$label :", style: const TextStyle(color: Colors.white)),
        const SizedBox(width: 70),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _dobBox(TextEditingController controller) {
    return SizedBox(
      width: 40,
      height: 40,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
