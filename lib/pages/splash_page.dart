import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_instaclone/pages/signin_page.dart';
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  static const String id = "splash_page";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTimer();
  }

  initTimer(){
    Timer(Duration(seconds: 2), (){
      Navigator.pushReplacementNamed(context, SignInPage.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color.fromRGBO(131, 58, 180, 1),
              Color.fromRGBO(193, 53, 132, 1),
            ]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: Text("Instagram", style: TextStyle(fontSize: 60, fontFamily: 'Billabong', color: Colors.white),),
              ),
            ),
            Text("All rights reserved", style: TextStyle(color: Colors.white, fontSize: 16),),
            SizedBox(height: 20,),
          ],
        ),
      )
    );
  }
}
