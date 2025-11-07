import 'package:flutter/material.dart';

class Cutofftime2 extends StatefulWidget {
  final String selectedOption;
  final List<String> items;

  const Cutofftime2({super.key, required this.items, required this.selectedOption});

  @override
  State<Cutofftime2> createState() => _Cutofftime2State();
}

class _Cutofftime2State extends State<Cutofftime2> {
  Map<String,TimeOfDay?> selectedTimes = {};
  Future<void> pickTime(String name) async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
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
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
              Expanded(child:ListView.separated(itemBuilder: (context,index){
                final name = widget.items[index];
                final selected = selectedTimes[name];
               return ListTile(
                  title: Text(
                    name,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  trailing: SizedBox(width: 120,
                    child: TextField(
                      decoration: InputDecoration(
                        suffixIcon: TextButton(
                        onPressed: () => pickTime(name),
                        child: selected == null
                            ? Icon(
                          Icons.access_time_outlined,
                          color: Colors.white,
                        )
                            : Text(
                          selected.format(context),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    ),
                  )
                );
              }, separatorBuilder: (context,index)=>Divider(thickness: 1,),
          itemCount:widget.items.length,

      ))
    ],
        ),
      ),
    );
  }
}
