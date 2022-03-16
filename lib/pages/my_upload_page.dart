import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class MyUploadPage extends StatefulWidget {
  const MyUploadPage({Key? key}) : super(key: key);

  @override
  _MyUploadPageState createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {

  File? imageFile;

  var captionController = TextEditingController();

  imageFromGallery() async {
    PickedFile? pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  _upLoadNewPost(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Upload", style: TextStyle(color: Colors.black, fontFamily: 'Billabong', fontSize: 32),),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              // _upLoadNewPost();
            },
            icon: Icon(Icons.post_add, color: Color.fromRGBO(245, 96, 64, 1),),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  imageFromGallery();
                },
                child: Container(
                    height: MediaQuery.of(context).size.width,
                    color: Colors.grey.withOpacity(0.4),
                    child: imageFile == null ?
                    Center(
                      child: Icon(Icons.add_a_photo, color: Colors.grey, size: 60,),
                    ) :
                    Image.file(imageFile!, fit: BoxFit.cover, )
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10, top: 10, left: 10),
                child: TextField(
                  controller: captionController,
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: "Caption",
                    hintStyle: TextStyle(fontSize: 17.0, color: Colors.black38)
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
