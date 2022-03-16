import 'package:flutter/material.dart';
import 'package:flutter_instaclone/pages/signin_page.dart';

import 'home_page.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static const String id = "signup_page";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();

  _callSignIn(){
    Navigator.pushReplacementNamed(context, SignInPage.id);
  }

  _callHomePage(){
    Navigator.pushReplacementNamed(context, HomePage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  colors: [
                    Color.fromRGBO(131, 58, 180, 1),
                    Color.fromRGBO(193, 53, 132, 1),
                  ]
              )
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Instagram", style: TextStyle(color: Colors.white, fontSize: 60, fontFamily: 'Billabong'),),
                      SizedBox(height: 20,),

                      //#fullname
                      Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white54.withOpacity(0.2)
                          ),
                          child: TextField(
                            controller: fullnameController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Fullname",
                                hintStyle: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 17,
                                ),
                                border: InputBorder.none

                            ),
                          )
                      ),
                      SizedBox(height: 20,),

                      //#email
                      Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white54.withOpacity(0.2)
                          ),
                          child: TextField(
                            controller: emailController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 17,
                                ),
                                border: InputBorder.none

                            ),
                          )
                      ),
                      SizedBox(height: 20,),

                      //#password
                      Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white54.withOpacity(0.2)
                          ),
                          child: TextField(
                            controller: passwordController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 17,
                                ),
                                border: InputBorder.none
                            ),
                          )
                      ),
                      SizedBox(height: 20,),
                      //#cpassword
                      Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white54.withOpacity(0.2)
                          ),
                          child: TextField(
                            controller: cpasswordController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 17,
                                ),
                                border: InputBorder.none
                            ),
                          )
                      ),
                      SizedBox(height: 20,),

                      //#SignIn
                      GestureDetector(
                        onTap: _callHomePage,
                        child: Container(
                            height: 50,
                            padding: EdgeInsets.only(right: 10, left: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white54.withOpacity(0.2),width: 2
                                ),
                                borderRadius: BorderRadius.circular(7)
                            ),
                            child: Center(
                              child: Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
                            )
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?", style: TextStyle(color: Colors.white,fontSize: 16),),
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap: _callSignIn,
                    child: Text("Sign In", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
