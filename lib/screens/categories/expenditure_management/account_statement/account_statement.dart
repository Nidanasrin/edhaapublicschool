import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AccountStatement extends StatefulWidget {
  const AccountStatement({super.key});

  @override
  State<AccountStatement> createState() => _AccountStatementState();
}

class _AccountStatementState extends State<AccountStatement> {
  DateTime? _startDate;
  DateTime? _endDate;
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  void msgbox(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text("Message"),
          content: Text("No Information Available"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("OK",style: TextStyle(color: Colors.indigo.shade900),))
          ],
        )
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.indigo.shade400,
              onPrimary: Colors.white,
              surface: Colors.blueGrey.shade800,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 5,
                  child: Text(
                    "Start Date",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child:  TextField(
                        onTap:  () => _selectDate(context, true),
                      decoration: InputDecoration(
                        filled: true,suffixIcon: IconButton(onPressed: ()=> _selectDate(context, true), icon: Icon(Icons.calendar_month)),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                          hintText:
                        _startDate == null
                            ? "Select Date"
                            : dateFormat.format(_startDate!),
                        hintStyle: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 10),

            // End Date
            Row(
              children: [
                const Expanded(
                  flex: 5,
                  child: Text(
                    "End Date",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Expanded(
                  flex: 5,
                    child: TextField(
    onTap:  () => _selectDate(context, false),

    decoration: InputDecoration(fillColor: Colors.white,
                        filled: true,suffixIcon: IconButton(onPressed: ()=> _selectDate(context, false), icon: Icon(Icons.calendar_month)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                        hintText:
                        _endDate == null
                            ? "Select Date"
                            : dateFormat.format(_endDate!),
                        hintStyle: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
               msgbox();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.blueGrey.shade900,
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white, width: 2),
              ),
              child: const Text("SUBMIT"),
            ),
          ],
        ),
      ),
    );
  }
}
