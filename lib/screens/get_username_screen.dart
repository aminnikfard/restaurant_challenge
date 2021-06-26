import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:restaurant_challenge_app/screens/auth_screen.dart';

import '../constants.dart';
import '../static_methods.dart';

class GetUsernameScreen extends StatefulWidget {
  static String id = "get_username_screen";

  @override
  _GetUsernameScreenState createState() => _GetUsernameScreenState();
}

class _GetUsernameScreenState extends State<GetUsernameScreen> {
  bool _hidePassword = true;

  TextEditingController usernameController,
      passwordController,
      rePasswordController;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  String username, password, rePassword;

  bool showLoadingProgress = false;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: ModalProgressHUD(
        inAsyncCall: showLoadingProgress,
        progressIndicator: kCustomProgressIndicator,
        child: SafeArea(
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
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
                        width: MediaQuery.of(context).size.width / 1,
                        height: MediaQuery.of(context).size.width / 1.2,
                        child: Image(
                          image: AssetImage("assets/images/logo.png"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
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
                      children: <Widget>[
                        Text(
                          "Please Enter Your Desired UserName And Password",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: <Widget>[
                              TextField(
                                controller: usernameController,
                                decoration: InputDecoration(
                                    labelText: "UserName*",
                                    labelStyle: TextStyle(fontSize: 14.0),
                                    suffixIcon: Icon(
                                      Icons.person,
                                      size: 17.0,
                                    )),
                              ),
                              TextField(
                                controller: passwordController,
                                obscureText: _hidePassword,
                                keyboardType: TextInputType.emailAddress,
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
                              TextField(
                                controller: rePasswordController,
                                obscureText: _hidePassword,
                                decoration: InputDecoration(
                                    labelText: "RePassword*",
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
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            FocusScopeNode currentFocus =
                            FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            submit();
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
                                "Create Account",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  submit() {
    if (isValid()) {
      uploadInfo();
    } else {
      // pass
    }
  }

  bool isValid() {
    username = usernameController.text;
    password = passwordController.text;
    rePassword = rePasswordController.text;

    if (username.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        StaticMethods.mySnackBar('Fill UserName', MediaQuery.of(context).size, kDialogErrorColor),
      );
      return false;
    }

    if (password.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        StaticMethods.mySnackBar('Fill Password', MediaQuery.of(context).size, kDialogErrorColor),
      );
      return false;
    }
    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        StaticMethods.mySnackBar('Your Password is less than six Number', MediaQuery.of(context).size, kDialogErrorColor),
      );
      return false;
    }
    if (password != rePassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        StaticMethods.mySnackBar(
            'Password does not match RePassword', MediaQuery.of(context).size, kDialogErrorColor),
      );
      return false;
    }
    return true;
  }

  uploadInfo() async {
    password = passwordController.text;
    showLoadingProgress = true;
    setState(() {});
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: username + '@test.com', password: password);
      auth.currentUser.updateDisplayName(usernameController.text);
      if (userCredential != null) {
        print('user is: ${userCredential.user}');
        uploadToDatabase(userCredential.user, password);
      } else {
        print('user is null');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        StaticMethods.mySnackBar(
            'The User Name is already in use by another account', MediaQuery.of(context).size, kDialogErrorColor),
      );
      print('myError: $e');
      showLoadingProgress = false;
      setState(() {});
    }
  }

  Future<void> uploadToDatabase(User user, password) async {
    try {
      setState(() {});
      Navigator.of(context).pushNamedAndRemoveUntil(
          AuthScreen.id, (Route<dynamic> route) => false);
      showLoadingProgress = false;
      return fireStore.collection('Users').add({
        'uid': user.uid,
        'username': user.email,
        'password': password,
      });
    } catch (e) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        StaticMethods.mySnackBar('sth went wrong', MediaQuery.of(context).size, kDialogErrorColor),
      );
      print(e);
    }
  }
}

