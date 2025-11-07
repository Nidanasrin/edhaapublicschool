import 'package:flutter/material.dart';
import 'package:raynottschool/dummydata/datas.dart';

class FacemappingDetails extends StatefulWidget {
  const FacemappingDetails({super.key});

  @override
  State<FacemappingDetails> createState() => _FacemappingDetailsState();
}

class _FacemappingDetailsState extends State<FacemappingDetails> {
  @override
  Widget build(BuildContext context) {
    final classNames = classStudents.keys.toList();
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(child:ListView.separated(itemBuilder: (context,index){
              final className = classNames[index];
              //final selected = selectedTimes[name];
              return ListTile(
                  title: Text(
                  className,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  trailing: SizedBox(width: 120,
                    child: Text("1000${index+1}",style: TextStyle(color: Colors.white,fontSize: 16),)
                  )
              );
            }, separatorBuilder: (context,index)=>Divider(thickness: 1,height: 5,),
              itemCount: classNames.length,
            ))
          ],
        ),
      ),
    );
  }
}
