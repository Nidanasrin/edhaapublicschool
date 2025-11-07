import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/fees/fees_standardisation/delete_classwise_details.dart';

import '../../../../dummydata/datas.dart';

class DeleteClasswise extends StatefulWidget {
  const DeleteClasswise({super.key});

  @override
  State<DeleteClasswise> createState() => _DeleteClasswiseState();
}

class _DeleteClasswiseState extends State<DeleteClasswise> {
        String? selectedYear;
        String? selectedValue;
        TextEditingController orgController =
        TextEditingController(text: "EDHAA PUBLIC SCHOOL");

    List<String> year = [
      "2015-16",
      "2016-17",
      "2017-18",
      "2018-19",
      "2019-20",
      "2020-21",
      "2021-22",
      "2022-23",
      "2023-24",
      "2024-26",
      "2025-26",
    ];

    @override
    void initState() {
      super.initState();
      selectedYear = "2025-26";
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        body: Center(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Academic year
              SizedBox(height: 50,),
              Row(
                children: [
                  const Expanded(
                    flex: 4,
                    child: Text(
                      "Select Academic Year:",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: DropdownButtonFormField<String>(
                      value: selectedYear,
                      isExpanded: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      items: year.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Organization Name
              Row(
                children: [
                  const Expanded(
                      flex: 4,
                      child: Text(
                        "Organization Name:",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                  Expanded(
                    flex: 5,
                    child: TextField(
                      controller: orgController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                  children: [
                    Expanded(flex: 4,child: Text("Class name       :",style: TextStyle(color: Colors.white,fontSize: 18),)),
                    Expanded(flex: 5,
                      child: DropdownButtonFormField<String>(
                          value: selectedValue,isExpanded: true,
                          decoration: InputDecoration(fillColor: Colors.white,
                              filled: true,hintText: "Select Class",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                          items: list.map((String value){
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: TextStyle(color: Colors.black),)
                            );
                          }).toList(),
                          onChanged: (value){
                            setState(() {
                              selectedValue = value;
                            });
                          }),
                    ),
                  ]
              ),
              SizedBox(height: 20,),
              // Header Row


              const SizedBox(height: 20),
              // Submit button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if(selectedValue==null){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Select a Class")));
                    }else{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> DeleteClasswiseDetails()));

                    }
                  },
                  child: const Text("SUBMIT"),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),

        ));
  }
}
