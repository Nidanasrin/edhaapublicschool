import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  List<String> numbers =[];
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  bool obscureNewPass = true;
  bool obscureConfirmPass = true;
  void msgbox(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text("Message"),
          content: Text("No Students Available"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
          ],
        )
    );
  }
  void showpasswordDialog({int? index}) {
    TextEditingController controller =
    TextEditingController(text: index != null ? numbers[index] : '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: Colors.indigo.shade900,
        content:Row(
            children: [
              Expanded(child: TextField(
                controller: controller,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Mobile number",

                  border: OutlineInputBorder(),
                ),
              ),
              )
            ]
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: Colors.white, width: 2)),
              backgroundColor: Colors.indigo.shade900,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
            child: Text("CANCEL"),
          ),SizedBox(width: 15,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: Colors.white, width: 2)),
              backgroundColor: Colors.indigo.shade900,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              setState(() {
                if (controller.text.trim().isEmpty) return;
                if (index == null) {
                  numbers.add(controller.text.trim());
                } else {
                  numbers[index] = controller.text.trim();
                }
              });
              msgbox();
            },
            child: Text("UPDATE"),
          ),
        ],
      ),
    );
  }
  void _updatePassword() {
    if (newPassController.text.isEmpty || confirmPassController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in both fields")),
      );
    } else if (newPassController.text != confirmPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Success"),
          content: const Text("Password updated successfully!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.pop(context); // go back to previous screen
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child:Padding(
        padding: const EdgeInsets.all(8.0),
        child:  Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            SizedBox(height: 20,),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text("New Password", style: const TextStyle(color: Colors.white,fontSize: 16)),
              ),
              Expanded(
                flex: 3,
                child: TextField(
                  controller: newPassController,
                  decoration: InputDecoration(
                    hintText: "New Password",
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.white,filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),suffixIcon: IconButton(
                    icon: Icon(
                      obscureNewPass
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureNewPass = !obscureNewPass;
                      });
                    },
                  ),
                  ),
                  ),
                ),
              ]
          ),
          SizedBox(height: 20,),
          Row(
          children: [
            Expanded(
              flex: 2,
              child: Text("Confirm Password", style: const TextStyle(color: Colors.white,fontSize: 16)),
            ),
            Expanded(
              flex: 3,
              child: TextField(
                obscureText: obscureConfirmPass,
                controller: confirmPassController,
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.white,filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),suffixIcon:IconButton(
                  icon:Icon(
                    obscureConfirmPass
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureConfirmPass = !obscureConfirmPass;
                    });
                  },
                ),
                ),
                ),
              ),
          ]
            ),
              SizedBox(height: 30,),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                    backgroundColor: Colors.blueGrey.shade900,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    _updatePassword();
                  },
                  child: const Text("UPDATE"),
                ),
              ),
              Spacer(),
              TextButton(onPressed: (){
             showpasswordDialog();
              }, child: Text("Set Password For Parents",style: TextStyle(color: Colors.white,),)),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
