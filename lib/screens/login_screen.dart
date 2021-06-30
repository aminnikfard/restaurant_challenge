import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:restaurant_challenge_app/screens/register_email_screen.dart';
import 'package:restaurant_challenge_app/screens/register_phone_screen.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../static_methods.dart';
import 'auth_screen.dart';


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
    User user = auth.currentUser;
    if (user != null) {
      getUserInfoFromDatabase(user);
    } else {
      // pass
    }
  }

  @override
  void initState() {
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Image(
                          width: 310.0,
                          image: AssetImage("assets/images/shape.png"),
                        )
                      ],
                    ),
                    Positioned(
                      width: size.width / 1,
                      height: size.width / 1.2,
                      child: Image(
                        image: AssetImage("assets/images/logo.png"),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400],
                        blurRadius: 5.0,
                        offset: Offset(0, 0),
                      )
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 18.0),
                  padding:
                  EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
                  child: Column(
                    children: [
                      Text(
                        "Login Account",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: "Email*",
                                labelStyle: TextStyle(fontSize: 14.0),
                                suffixIcon: Icon(
                                  Icons.person,
                                  size: 17.0,
                                ),
                              ),
                            ),
                            TextField(
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          onLoginPressed();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Theme.of(context).primaryColor,
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Divider(
                        thickness: 0.8,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Register Now : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor)),
                          SocialIcon(
                            iconSrc: Icons.email_rounded,
                            press: () {
                              FocusScopeNode currentFocus =
                              FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              Navigator.pushNamed(
                                  context, RegisterEmailScreen.id);
                            },
                          ),
                          SocialIcon(
                            iconSrc: Icons.phone,
                            press: () {
                              Navigator.pushNamed(
                                  context, RegisterPhoneScreen.id);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
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
      ScaffoldMessenger.of(context).showSnackBar(
        StaticMethods.mySnackBar('Please Fill email', MediaQuery.of(context).size, kDialogErrorColor),
      );
      return false;
    }
    if (password.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        StaticMethods.mySnackBar('Please Fill password', MediaQuery.of(context).size, kDialogErrorColor),
      );
      return false;
    }
    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        StaticMethods.mySnackBar('Wrong Password', MediaQuery.of(context).size, kDialogErrorColor),
      );
      return false;
    }

    return true;
  }

  uploadInfo() async {
    showLoadingProgress = true;
    setState(() {});
    try {
      UserCredential userCredential =
      await auth.signInWithEmailAndPassword(
          email: email, password: password).onError((error, stackTrace) => error);
      showLoadingProgress = false;
      setState(() {});
      if (userCredential != null) {
        print('user is: ${userCredential.user}');
        getUserInfoFromDatabase(userCredential.user);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          StaticMethods.mySnackBar(
              'This User does not exist', MediaQuery.of(context).size, kDialogErrorColor),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        StaticMethods.mySnackBar(
            'Wrong Email or Password', MediaQuery.of(context).size, kDialogErrorColor),
      );
      print('myError: $e');
      showLoadingProgress = false;
      setState(() {});
    }
  }

  onLoginPressed() {
    if (isValid()) {
      uploadInfo();
    } else {

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
      print(e);
    }
  }
}

class SocialIcon extends StatelessWidget {
  final IconData iconSrc;
  final Function press;

  const SocialIcon({
    Key key,
    this.iconSrc,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Theme.of(context).primaryColor,
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconSrc,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
