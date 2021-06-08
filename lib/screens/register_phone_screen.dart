import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_challenge_app/screens/home_screen.dart';
import 'package:restaurant_challenge_app/screens/register_email_screen.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class RegisterPhoneScreen extends StatefulWidget {
  static String id = 'register_phone_screen';

  @override
  _RegisterPhoneScreenState createState() => _RegisterPhoneScreenState();
}

class _RegisterPhoneScreenState extends State<RegisterPhoneScreen> {
  bool _hidePassword = true;
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId;

  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential?.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  getMobileFormWidget(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 20.0,
                padding: EdgeInsets.only(top: 60),
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Image(
                width: 310.0,
                image: AssetImage("assets/images/shape.png"),
              )
            ],
          ),
        ),
        Container(
          height: 40.0,
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                top: -120,
                child: Image(
                  image: AssetImage("assets/images/logo.png"),
                ),
              )
            ],
          ),
        ),
        Expanded(
            child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.grey[200],
                    blurRadius: 2.0,
                    offset: Offset(0, 5.0))
              ]),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Register Account Using Phone Number",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: phoneController,
                          decoration: InputDecoration(
                              labelText: "Phone Number*",
                              labelStyle: TextStyle(fontSize: 14.0),
                              suffixIcon: Icon(
                                Icons.phone,
                                size: 17.0,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        showLoading = true;
                      });

                      await _auth.verifyPhoneNumber(
                        phoneNumber: phoneController.text,
                        verificationCompleted: (phoneAuthCredential) async {
                          setState(() {
                            showLoading = false;
                          });
                          //signInWithPhoneAuthCredential(phoneAuthCredential);
                        },
                        verificationFailed: (verificationFailed) async {
                          setState(() {
                            showLoading = false;
                          });
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text(verificationFailed.message)));
                        },
                        codeSent: (verificationId, resendingToken) async {
                          setState(() {
                            showLoading = false;
                            currentState =
                                MobileVerificationState.SHOW_OTP_FORM_STATE;
                            this.verificationId = verificationId;
                          });
                        },
                        codeAutoRetrievalTimeout: (verificationId) async {},
                      );
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
                      width: 200.0,
                      child: Center(
                        child: Text(
                          "SEND",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 12.0),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
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
                                            RegisterEmailScreen()));
                              },
                              child: Text(
                                "Email Address",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 5.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute());
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                  )
                ],
              ),
            )
          ],
        ))
      ],
    );
  }

  getOtpFormWidget(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 20.0,
                padding: EdgeInsets.only(top: 60),
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Image(
                width: 310.0,
                image: AssetImage("assets/images/shape.png"),
              )
            ],
          ),
        ),
        Container(
          height: 40.0,
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                top: -120,
                child: Image(
                  image: AssetImage("assets/images/logo.png"),
                ),
              )
            ],
          ),
        ),
        Expanded(
            child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.grey[200],
                    blurRadius: 2.0,
                    offset: Offset(0, 5.0))
              ]),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Create Account",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: otpController,
                          decoration: InputDecoration(
                              labelText: "Enter OTP*",
                              labelStyle: TextStyle(fontSize: 14.0),
                              suffixIcon: Icon(
                                Icons.mail,
                                size: 17.0,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      PhoneAuthCredential phoneAuthCredential =
                          PhoneAuthProvider.credential(
                              verificationId: verificationId,
                              smsCode: otpController.text);

                      signInWithPhoneAuthCredential(phoneAuthCredential);
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
                      width: 200.0,
                      child: Center(
                        child: Text(
                          "VERIFY",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                  ),
                ],
              ),
            ),
          ],
        ))
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: showLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
          padding: const EdgeInsets.all(16),
        ));
  }
}
