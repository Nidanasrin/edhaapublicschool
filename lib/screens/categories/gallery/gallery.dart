import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<String> albums = [];
  bool photoSelected = false;


  File? selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }


  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  void imageBox(){
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
          backgroundColor: Colors.white,
          content: Column(mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,

                      side: BorderSide(color: Colors.indigo.shade900,width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  onPressed: pickImage, child: Text("OPEN CAMERA",style: TextStyle(color: Colors.indigo.shade900),)),
              SizedBox(height: 10,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.indigo.shade900,width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  onPressed: _pickImage, child: Text("PICK IMAGE FROM GALLERY",style: TextStyle(color: Colors.indigo.shade900),))
            ],
          ),
        ));
  }

  void showAlbumDialog({int? index}) {
    TextEditingController controller =
    TextEditingController(text: index != null ? albums[index] : '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: Colors.white,
        title: const Text(
          "CREATE ALBUM",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        content: Row(
          children: [
            const Expanded(
              flex: 2,
              child: Text(
                "Album Name:",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Album name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: const BorderSide(color: Colors.black, width: 2),
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              String name = controller.text.trim();
              if (name.isNotEmpty) {
                setState(() {
                  if (index != null) {
                    albums[index] = name;
                  } else {
                    albums.add(name);
                  }
                });
                Navigator.pop(context);
              }
            },
            child: const Text("SUBMIT"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 20,),
          Expanded(
            child: albums.isEmpty
                ? const Center(
              child: Text(
                "No albums yet",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
                : ListView.separated(
              itemCount: albums.length,
              itemBuilder: (context, index) => ListTile(
                onTap: ()=> imageBox(),
                  title: Text(
                    albums[index],
                    style: const TextStyle(color: Colors.white),
                  ),
                ), separatorBuilder: (context,index)=> Divider(height: 10,color: Colors.white,thickness: 1,),
              ),
            ),
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
              // ✅ now works correctly for creating a new album
              onPressed: () => showAlbumDialog(),
              child: const Text("CREATE NEW ALBUM"),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
