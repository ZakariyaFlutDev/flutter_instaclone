import 'package:flutter/material.dart';
import 'package:flutter_instaclone/model/post_model.dart';
class MyFeedPage extends StatefulWidget {
  const MyFeedPage({Key? key}) : super(key: key);

  @override
  _MyFeedPageState createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {

  List<Post> items = [];

  String postImg1 = "https://images7.alphacoders.com/461/461013.jpg";
  String postImg2 = "https://avatars.mds.yandex.net/i?id=64fbc395290610a625edf69848fd2a99-4451037-images-thumbs&ref=rim&n=33&w=212&h=150";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items.add(new Post(image: postImg1, caption: "Bu test uchun yozilgan ma'lumot"));
    items.add(new Post(image: postImg2, caption: "Bu test uchun yozilgan ma'lumot"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Instagram", style: TextStyle(color: Colors.black, fontFamily: 'Billabong', fontSize: 30),),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.camera_alt, color: Colors.black,),
          )
        ],
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
          Divider(),

          //#userinfos
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      child: Image(
                        image: AssetImage("assets/images/ic_person.jpg"),
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Username", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),),
                        Text("March 17, 2022", style: TextStyle(color: Colors.black),)
                      ],
                    )
                  ],
                ),
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.more_horiz_outlined, color: Colors.black,size: 35,),
                )
              ],
            ),
          ),
          //#image
          Image.network(post.image!, fit: BoxFit.cover, width: double.infinity,),
          //#likeshare
          Row(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.favorite_border_outlined),
                  ),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.send_rounded),
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
