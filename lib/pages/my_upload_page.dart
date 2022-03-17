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
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);

    // XFile? pickedFile = (await ImagePicker()
    //     .pickImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200));
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  _upLoadNewPost(){
    String caption = captionController.text.toString().trim();
    if(caption == null) return;
    if(imageFile == null) return;
  }

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
              _upLoadNewPost();
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
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width,
                    color: Colors.grey.withOpacity(0.4),
                    child: imageFile == null ?
                    Center(
                      child: Icon(Icons.add_a_photo, color: Colors.grey, size: 60,),
                    )
                      : Stack(
                          children: [
                            Container(
                              height: double.infinity,
                              child: Image.file(imageFile!, fit: BoxFit.cover, ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              color: Colors.black12,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.highlight_remove, color: Colors.white,),
                                onPressed: (){
                                  setState(() {
                                    imageFile = null;
                                  });
                                },
                              )
                            ],
                          ),
                          )
                      ],
                    )

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
