import 'package:flutter/material.dart';
import 'package:flutter_instaclone/model/user_model.dart';
class MySearchPage extends StatefulWidget {
  const MySearchPage({Key? key}) : super(key: key);

  @override
  _MySearchPageState createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  var searchController = TextEditingController();

  List<UserModel> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items.add(UserModel(fullname: "Zakariya", email: "zakariya@gmail.com", password: "123qwe"));
    items.add(UserModel(fullname: "Zakariya", email: "zakariya@gmail.com", password: "123qwe"));
    items.add(UserModel(fullname: "Zakariya", email: "zakariya@gmail.com", password: "123qwe"));
    items.add(UserModel(fullname: "Zakariya", email: "zakariya@gmail.com", password: "123qwe"));
    items.add(UserModel(fullname: "Zakariya", email: "zakariya@gmail.com", password: "123qwe"));
    items.add(UserModel(fullname: "Zakariya", email: "zakariya@gmail.com", password: "123qwe"));
    items.add(UserModel(fullname: "Zakariya", email: "zakariya@gmail.com", password: "123qwe"));
    items.add(UserModel(fullname: "Zakariya", email: "zakariya@gmail.com", password: "123qwe"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Search", style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'Billabong'),),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            //#searchUser
            Container(
              padding: EdgeInsets.only(right: 10, left: 10),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.grey.withOpacity(0.2),
              ),
              height: 45,
              child: TextField(
                onChanged: (input){
                  print(input);
                },
                controller: searchController,
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  hintText: "Search",
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                  icon: Icon(Icons.search, color: Colors.grey,)
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (ctx,i){
                  return _itemOfUser(items[i]);
                },
              ),
            )
          ],
        ),
      )
    );
  }

  Widget _itemOfUser(UserModel user){
    return Container(
      height: 90,
      child: Row(
        children: [

          //#profileImage
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70),
              border: Border.all(
                width: 1.5,
                color: Color.fromRGBO(193, 53, 132, 1),
              )
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22.5),
              child: Image(
                image: AssetImage("assets/images/ic_person.jpg"),
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(width: 15,),

          //#fullname #email
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(user.fullname, style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 3,),
              Text(user.email, style: TextStyle(color: Colors.black54),),
            ],
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey
                    )
                  ),
                  child: Center(
                    child: Text("Follow"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
