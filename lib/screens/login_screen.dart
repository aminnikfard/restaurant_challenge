import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_challenge_app/screens/register_email_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../static_methods.dart';
import 'auth_screen.dart';
import 'login_to_challenge_room.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  static var formatter = NumberFormat('###,###,###,###,###,###,###,###,###');

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _hidePassword = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailController, passwordController;
  Size size;
  FocusNode node;

  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child('Users');

  String email, password;

  bool showLoadingProgress = false;

  getUser() {
    print('fff');
    User user = auth.currentUser;
    if (user != null) {
      getUserInfoFromDatabase(user);
    } else {
      // pass
    }
  }

  @override
  void initState() {
    print('dddd');
    emailController = TextEditingController();
    passwordController = TextEditingController();

    Future.delayed(
      Duration(microseconds: 200),
      () {
        getUser();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    node = FocusScope.of(context);

    return Scaffold(
      backgroundColor: kColorWhite,
      body: ModalProgressHUD(
        inAsyncCall: showLoadingProgress,
        progressIndicator: kCustomProgressIndicator,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image(
                    image: AssetImage("assets/images/logo.png"),
                    width: size.width * 0.9,
                    height: size.width * 0.9,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: kColorWhite,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Email*",
                          labelStyle: TextStyle(fontSize: 14.0),
                          suffixIcon: Icon(
                            Icons.mail,
                            size: 17.0,
                          ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: kColorWhite,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: passwordController,
                      obscureText: _hidePassword,
                      decoration: InputDecoration(
                          labelText: "Password*",
                          labelStyle: TextStyle(fontSize: 14.0),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            },
                            icon: Icon(
                              _hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 17.0,
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {onLoginPressed();},
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: kColorWhite,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                blurRadius: 2.0,
                                offset: Offset(0, 4.0))
                          ]),
                      margin: EdgeInsets.only(top: 20.0),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {Navigator.pushNamed(context, RegisterEmailScreen.id);},
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Theme.of(context).primaryColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                blurRadius: 5.0,
                                offset: Offset(0, 0))
                          ]),
                      margin: EdgeInsets.only(top: 20.0),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValid() {
    email = emailController.text;
    password = passwordController.text;
    if (email.length == 0) {
      StaticMethods.showErrorDialog(context: context, text: 'Fill email');
      return false;
    }
    if (password.length < 6) {
      StaticMethods.showErrorDialog(context: context, text: 'Fill password');
      return false;
    }
    return true;
  }

  uploadInfo() async {
    showLoadingProgress = true;
    setState(() {});
    try {
      print('signing in');
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('after singing in');
      showLoadingProgress = false;
      setState(() {});
      if (userCredential != null) {
        print('user is: ${userCredential.user}');
        getUserInfoFromDatabase(userCredential.user);
      } else {
        print('user is null');
      }
    } catch (e) {
      print('myError: $e');
      showLoadingProgress = false;
      setState(() {});
    }
  }

  onLoginPressed() {
    if (isValid()) {
      uploadInfo();
    } else {
      // pass
    }
  }

  getUserInfoFromDatabase(User user) async {
    showLoadingProgress = true;
    setState(() {});
    try {
      showLoadingProgress = false;
      setState(() {});
      Navigator.popAndPushNamed(
        context,
        AuthScreen.id,
      );
    } catch (e) {
      showLoadingProgress = false;
      setState(() {});
      StaticMethods.showErrorDialog(context: context, text: 'sth went wrong');
      print(e);
    }
  }
}
