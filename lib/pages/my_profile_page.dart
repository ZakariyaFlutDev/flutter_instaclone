import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instaclone/model/post_model.dart';
import 'package:flutter_instaclone/model/user_model.dart';
import 'package:flutter_instaclone/pages/signin_page.dart';
import 'package:flutter_instaclone/services/data_service.dart';
import 'package:flutter_instaclone/services/file_service.dart';
import 'package:image_picker/image_picker.dart';

import '../services/auth_service.dart';
class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {

  List<Post> posts = [];
  File? imageFile;
  bool _isList = true;
  String fullname = "", email = "", img_url = "";

  String postImg1 = "https://images7.alphacoders.com/461/461013.jpg";
  String postImg2 = "https://avatars.mds.yandex.net/i?id=64fbc395290610a625edf69848fd2a99-4451037-images-thumbs&ref=rim&n=33&w=212&h=150";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    posts.add(Post(image: postImg1, caption: "Bu test uchun yozilgan ma'lumot"));
    posts.add(Post(image: postImg2, caption: "Bu test uchun yozilgan ma'lumot"));
    posts.add(Post(image: postImg2, caption: "Bu test uchun yozilgan ma'lumot"));
    posts.add(Post(image: postImg1, caption: "Bu test uchun yozilgan ma'lumot"));
    posts.add(Post(image: postImg2, caption: "Bu test uchun yozilgan ma'lumot"));
    posts.add(Post(image: postImg2, caption: "Bu test uchun yozilgan ma'lumot"));
    posts.add(Post(image: postImg1, caption: "Bu test uchun yozilgan ma'lumot"));
    posts.add(Post(image: postImg2, caption: "Bu test uchun yozilgan ma'lumot"));
    posts.add(Post(image: postImg2, caption: "Bu test uchun yozilgan ma'lumot"));
    _apiLoadUser();
  }

  Future imageFromGallery() async {
    print("Rasm tanlashga kirdi");
    final _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery,);
    print("Keyingi holat");
    if (pickedFile != null) {
      print("Picked file");
      setState(() {
        imageFile = File(pickedFile.path);
      });
      print("Imagefilega saqladi");

    }else{
      print("PIcked file nullga teng");
    }

    _apiChangePhoto();
  }

  imageFromCamera() async {
    XFile? pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 200, maxWidth: 200);
    if (pickedFile != null) {
      print("Picked file");
      setState(() {
        imageFile = File(pickedFile.path);
      });
      print("Imagefilega saqladi");
    }

    _apiChangePhoto();

  }

  void _apiChangePhoto(){
    print("Changega o'tdi");
    if(imageFile == null) return;
    
    FileService.uploadUserImage(imageFile!).then((downloadUrl) => {
      _apiUpdateUser(downloadUrl)
    });
  }

  void _apiUpdateUser(String downloadUrl) async{
    UserModel userModel = await DataService.loadUser();
    userModel.img_url = downloadUrl;
    await DataService.updateUser(userModel);
    _apiLoadUser();
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        imageFromGallery();
                        Navigator.of(context).pop();
                      }),
                   ListTile(
                    leading:  Icon(Icons.photo_camera),
                    title:  Text('Camera'),
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

  _apiLoadUser(){
    DataService.loadUser().then((value) => {
      _showUserInfo(value),
    });
  }

  void _showUserInfo(UserModel userModel){
    setState(() {
      fullname = userModel.fullname;
      email = userModel.email;
      img_url = userModel.img_url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Profile", style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'Billabong'),),
        actions: [
          IconButton(
            onPressed: (){
              AuthService.signOut(context);
              Navigator.pushReplacementNamed(context, SignInPage.id);
            },
            icon: Icon(Icons.exit_to_app),
            color: Colors.black87,
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [

            //#myphoto
            GestureDetector(
              onTap: (){
                _showPicker(context);
              },
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(37),
                        border: Border.all(
                          width: 2,
                          color: Color.fromRGBO(193, 53, 132, 1),
                        )
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: img_url.isEmpty ? Image(
                        image: AssetImage("assets/images/ic_person.jpg"),
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      )
                          : CachedNetworkImage(
                            width: double.infinity,
                            imageUrl: img_url,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Container(
                    height: 83,
                    width: 83,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(Icons.add_circle, color: Colors.pink,)
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),

            //#myinfos
            Text(fullname.toUpperCase(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
            SizedBox(height: 3,),
            Text(email, style: TextStyle(color: Colors.black54,fontWeight: FontWeight.normal, fontSize: 14),),

            //myCounts
            Container(
              height: 80,
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("465", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                          SizedBox(height: 3,),
                          Text("POSTS", style: TextStyle(color: Colors.black54,fontWeight: FontWeight.normal, fontSize: 14),),

                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 1,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("3,121", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                          SizedBox(height: 3,),
                          Text("FOLLOWERS", style: TextStyle(color: Colors.black54,fontWeight: FontWeight.normal, fontSize: 14),),

                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 1,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("98", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                          SizedBox(height: 3,),
                          Text("FOLLOWING", style: TextStyle(color: Colors.black54,fontWeight: FontWeight.normal, fontSize: 14),),

                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),

            //#isList
            Container(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.list),
                      onPressed: (){
                        setState(() {
                          _isList = true;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.grid_on_outlined),
                      onPressed: (){
                        setState(() {
                          _isList = false;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),

            Expanded(
              child: GridView.builder(
                itemCount: posts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _isList ? 1 : 2),
                itemBuilder: (ctx,i){
                  return _itemOfPost(posts[i]);
                },
              ),
            )
          ],
        ),
      )
    );
  }

  Widget _itemOfPost(Post post){
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              width: double.infinity,
              imageUrl: post.image!,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(height: 5,),
          Text(post.caption!,style: TextStyle(color: Colors.black87.withOpacity(0.7),), maxLines: 2,)
        ],
      ),
    );
  }
}
