import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instaclone/model/user_model.dart';
import 'package:flutter_instaclone/pages/signin_page.dart';
import 'package:flutter_instaclone/services/data_service.dart';
import 'package:flutter_instaclone/services/utils_service.dart';

import '../services/auth_service.dart';
import '../services/prefs_service.dart';
import 'home_page.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static const String id = "signup_page";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isLoading = false;

  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();

  _callSignIn(){
    Navigator.pushReplacementNamed(context, SignInPage.id);
  }

  _doSignUp(){
    String fullname = fullnameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String cpassword = cpasswordController.text.toString().trim();
    if(fullname.isEmpty || email.isEmpty || password.isEmpty) return;

    //valid email
    if(!Utils.emailValid(email)){
      Utils.showToast("Email xato kiritildi");
      return;
    }

    //valid password
    if(!Utils.passwordValid(password)){
      Utils.showToast("Parol xato kiritildi");
      return;
    }

    //valid password and cpasswword
    if(cpassword != password){
      print("Bu yerda xato ekanligi haqida xat chiqishi kerak");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    UserModel usermodel = new UserModel(fullname: fullname, email: email, password: password);

    AuthService.signUp(email: email, password: password).then((value) => {
      _getFirebaseUser(usermodel,value!),
    });
  }

  _getFirebaseUser(UserModel userModel,Map<String, User?> map) async{

    setState(() {
      _isLoading = false;
    });

    User? firebaseUser;
    if(!map.containsKey("SUCCESS")){
      if(map.containsKey("ERROR_EMAIL_ALREADY_IN_USE"))
        Utils.showToast("Email already in use");
      if(map.containsKey("ERROR"))
        Utils.showToast("Try again later");
      return;
    }

    firebaseUser = map["SUCCESS"];
    if(firebaseUser == null) return;

    await Prefs.saveUserId(firebaseUser.uid);
    DataService.storeUser(userModel).then((value) => {
      Navigator.pushReplacementNamed(context, HomePage.id),
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
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
              child: Stack(
                children: [
                  Column(
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
                                    obscureText: true,
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
                                    obscureText: true,
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
                                onTap: _doSignUp,
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
                                      child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
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
                  _isLoading ? Center(
                    child: CircularProgressIndicator(),
                  ) :
                  SizedBox.shrink(),
                ],
              )
          ),
        )
    );
  }
}
