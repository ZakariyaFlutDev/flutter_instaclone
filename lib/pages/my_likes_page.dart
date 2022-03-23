import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/post_model.dart';
class MyLikesPage extends StatefulWidget {
  const MyLikesPage({Key? key}) : super(key: key);

  @override
  _MyLikesPageState createState() => _MyLikesPageState();
}

class _MyLikesPageState extends State<MyLikesPage> {

  List<Post> items = [];

  String postImg1 = "https://images7.alphacoders.com/461/461013.jpg";
  String postImg2 = "https://avatars.mds.yandex.net/i?id=64fbc395290610a625edf69848fd2a99-4451037-images-thumbs&ref=rim&n=33&w=212&h=150";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items.add(Post(image: postImg1, caption: "Bu test uchun yozilgan ma'lumot"));
    items.add(Post(image: postImg2, caption: "Bu test uchun yozilgan ma'lumot"));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text("Likes", style: TextStyle(color: Colors.black, fontFamily: 'Billabong', fontSize: 30),),
          centerTitle: true,

        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (ctx, i){
            return _itemOfList(items[i]);
          },
        )
    );
  }

  Widget _itemOfList(Post post){
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const Divider(),

          //#userinfos
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const ClipRRect(
                      child: Image(
                        image: AssetImage("assets/images/ic_person.jpg"),
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Username", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),),
                        Text("March 17, 2022", style: TextStyle(color: Colors.black),)
                      ],
                    )
                  ],
                ),
                IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.more_horiz_outlined, color: Colors.black,size: 35,),
                )
              ],
            ),
          ),

          //#image
          CachedNetworkImage(
            width: double.infinity,
            imageUrl: post.image!,
            fit: BoxFit.cover,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          //#likeshare
          Row(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.favorite, color: Colors.red,)
                  ),
                  IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.send_rounded),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

