import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:restaurant_challenge_app/screens/auth_screen.dart';
import 'package:restaurant_challenge_app/screens/get_username_screen.dart';
import 'package:restaurant_challenge_app/screens/login_screen.dart';
import 'package:restaurant_challenge_app/screens/register_phone_screen.dart';
import '../constants.dart';
import '../static_methods.dart';


class RegisterEmailScreen extends StatefulWidget {
  static String id = 'register_email_screen';

  @override
  _RegisterEmailScreenState createState() => _RegisterEmailScreenState();
}

class _RegisterEmailScreenState extends State<RegisterEmailScreen> {

  TextEditingController emailController, otpController;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  String name, email, otp, rePassword;

  bool showLoadingProgress = false;

  getUser() {
    User user = auth.currentUser;
    if (user != null) {
      StaticMethods.simplePopAndPushNavigation(
          context: context, routeName: AuthScreen.id);
    } else {
      //pass
    }
  }

  @override
  void initState() {
    Future.delayed(
      Duration(microseconds: 300),
          () {
        getUser();
      },
    );
    emailController = TextEditingController();
    otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    otpController.dispose();
    super.dispose();
  }

  void sendOtp() async {
    EmailAuth.sessionName = "Test Session";
    var res = await EmailAuth.sendOtp(receiverMail: emailController.text);
    if (res) {
      print('send');
      ScaffoldMessenger.of(context).showSnackBar(
        StaticMethods.mySnackBar(
            'Send Email For you', MediaQuery.of(context).size,kDialogSuccessColor),
      );
    } else {
      print('problem');
      ScaffoldMessenger.of(context).showSnackBar(
        StaticMethods.mySnackBar(
            'There is a problem, try again', MediaQuery.of(context).size, kDialogErrorColor),
      );
    }
  }

  void verifyOtp() async {
    var res = EmailAuth.validate(
        receiverMail: emailController.text, userOTP: otpController.text);
    if (res) {
      print('otp');
      Navigator.popAndPushNamed(context, GetUsernameScreen.id);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        StaticMethods.mySnackBar('Wrong OTP', MediaQuery.of(context).size,kDialogErrorColor),
      );
      print('invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                        width: size.width / 1,
                        height: size.width / 1.2,
                        child: Image(
                          image: AssetImage("assets/images/logo.png"),
                        ),
                      ),
                      IconButton(
                        iconSize: 20.0,
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                      ),
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
                      children: <Widget>[
                        Text(
                          "Register Account Using Email Address",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: <Widget>[
                              TextField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    labelText: "Email*",
                                    labelStyle: TextStyle(fontSize: 14.0),
                                    suffixIcon: TextButton(
                                      child: Text('Send OTP'),
                                      onPressed: () => sendOtp(),
                                    )),
                              ),
                              TextField(
                                controller: otpController,
                                decoration: InputDecoration(
                                  labelText: "OTP*",
                                  labelStyle: TextStyle(fontSize: 14.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            FocusScopeNode currentFocus =
                            FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            verifyOtp();
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
                                "Verify OTP",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Or Register using",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(width: 5.0),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterPhoneScreen()));
                              },
                              child: Text(
                                "Phone Number",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                            )
                          ],
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

}
