import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Cutofftime2 extends StatefulWidget {
  final String selectedOption;
  final List<String> items;

  const Cutofftime2({
    super.key,
    required this.items,
    required this.selectedOption,
  });

  @override
  State<Cutofftime2> createState() => _Cutofftime2State();
}

class _Cutofftime2State extends State<Cutofftime2> {
  Map<String, TimeOfDay?> selectedTimes = {};
  Map<String, TextEditingController> controllers = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    for(var item in widget.items){
      controllers[item] = TextEditingController();
    }
  }

  Future<void> saveToFirebase() async {
    setState(() {
      isLoading = true;
    });
    try {
      Map<String, String> dataToSave = {};
      selectedTimes.forEach((key, value) {
        if (value != null) {
          dataToSave[key] = value != null ? value!.format(context) : "";
        }
      });
      await FirebaseFirestore.instance
          .collection('attendance')
          .doc('face_attendance')
          .collection('Cut Off Time')
          .doc(widget.selectedOption)
          .set(dataToSave);

      msgBox();
    } catch (e) {
      print('Error : $e');
    } finally {
      isLoading = false;
    }
  }

  Future<void> pickTime(String name) async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: selectedTimes[name] ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.pink, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.pink, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (time != null) {
      setState(() {
        selectedTimes[name] = time;
        controllers[name]!.text = time.format(context);
      });
    }
  }

  void msgBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        title: Text("Message"),
        content: Text("Cut Off Time Updated Successfully"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text("OK", style: TextStyle(color: Colors.indigo.shade900)),
          ),
        ],
      ),
    );
  }

  void showEditDeleteDialog(String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.indigo.shade900),
                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.indigo.shade900,
              ),
              onPressed: () {
                Navigator.pop(context);
                pickTime(name);
              },
              child: Text(
                "EDIT",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.indigo.shade900),
                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.indigo.shade900,
              ),
              onPressed: () {
                setState(() {
                  selectedTimes[name] = null;
                  controllers[name]!.clear();
                });
                Navigator.pop(context);
              },
              child: Text(
                "DELETE",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final name = widget.items[index];
                  final selected = selectedTimes[name];
                  return ListTile(
                    title: Text(
                      name,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    trailing: SizedBox(
                      width: 120,
                      child: TextField(
                        controller: controllers[name],
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          suffixIcon: selected == null
                              ? IconButton(
                                  onPressed: () => pickTime(name),
                                  icon: Icon(Icons.access_time),
                                  color: Colors.white,
                                )
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Text(
                                    //   selected.format(context),
                                    //   style: const TextStyle(
                                    //     color: Colors.white,
                                    //     fontSize: 16,
                                    //   ),
                                    // ),
                                    IconButton(
                                      onPressed: () =>
                                          showEditDeleteDialog(name),
                                      icon: Icon(Icons.edit_calendar_outlined),
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                        ),
                        onTap: () {
                          if (selected == null) {
                            pickTime(name);
                          } else {
                            showEditDeleteDialog(name);
                          }
                        },
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(thickness: 1),
                itemCount: widget.items.length,
              ),
            ),
            if (selectedTimes != null)
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
                  onPressed: saveToFirebase,
                  child: Text(
                    'SAVE',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
