import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class MyUploadPage extends StatefulWidget {
  MyUploadPage({Key? key, required this.pageController}) : super(key: key);

  PageController pageController;

  @override
  _MyUploadPageState createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {

  File? imageFile;

  var captionController = TextEditingController();

  imageFromGallery() async {
    XFile? pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  imageFromCamera() async {
    XFile? pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 200, maxWidth: 200);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        imageFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imageFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }


  _upLoadNewPost(){
    String _caption = captionController.text.toString().trim();
    if(_caption.isEmpty)return;
    if(imageFile == null) return;

    widget.pageController.animateToPage(0,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Upload", style: TextStyle(color: Colors.black, fontFamily: 'Billabong', fontSize: 32),),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _upLoadNewPost,
            icon: const Icon(Icons.post_add, color: Color.fromRGBO(245, 96, 64, 1),),
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
                  _showPicker(context);
                },
                child: Container(
                  width: double.infinity,
                    height: MediaQuery.of(context).size.width,
                    color: Colors.grey.withOpacity(0.4),

                    child: imageFile == null ?
                    const Center(
                      child: Icon(Icons.add_a_photo, color: Colors.grey, size: 60,),
                    )
                      : Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Image.file(imageFile!, fit: BoxFit.cover,),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          height: double.infinity,
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
                margin: const EdgeInsets.only(right: 10, top: 10, left: 10),
                child: TextField(
                  controller: captionController,
                  style: const TextStyle(color: Colors.black),
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
