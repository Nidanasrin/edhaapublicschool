import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/fees/account_department/add_accountant.dart';

class AccountDepartment extends StatefulWidget {
  const AccountDepartment({super.key});

  @override
  State<AccountDepartment> createState() => _AccountDepartmentState();
}

class _AccountDepartmentState extends State<AccountDepartment> {
  List<String> accountants = ["K Devi"];

  void msgBox(String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        title: const Text("Message"),
        content: const Text(
          "Are you sure you want to remove the selected Accountant?",
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("NO", style: TextStyle(color: Colors.green.shade900)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                accountants.remove(name);
              });
              Navigator.pop(context);
            },
            child: Text("YES", style: TextStyle(color: Colors.indigo.shade900)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            Expanded(
              child: accountants.isEmpty
                  ? const Center(
                child: Text(
                  "No accountants added yet",
                  style: TextStyle(color: Colors.white70),
                ),
              )
                  : ListView.separated(
                itemBuilder: (context, index) {
                  final name = accountants[index];
                  return ListTile(
                    onTap: () => msgBox(name),
                    title: Text(
                      name,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                const Divider(thickness: 1, height: 10, color: Colors.white),
                itemCount: accountants.length,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey.shade900,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(width: 2, color: Colors.white),
                  ),
                ),
                onPressed: () async {
                  final newAccountant = await Navigator.push<String>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddAccountant(),
                    ),
                  );
                  if (newAccountant != null && newAccountant.trim().isNotEmpty) {
                    setState(() {
                      accountants.add(newAccountant);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$newAccountant added successfully'),
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: const Text('ADD NEW ACCOUNTANT'),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
