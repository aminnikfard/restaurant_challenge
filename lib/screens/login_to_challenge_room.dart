import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_challenge_app/constants.dart';
import 'package:restaurant_challenge_app/models/notifier.dart';
import 'package:restaurant_challenge_app/screens/info_challenge_screen.dart';

class LoginChallengeRoom extends StatefulWidget {
  static String id = 'login_challenge_room';

  @override
  _LoginChallengeRoomState createState() => _LoginChallengeRoomState();
}

class _LoginChallengeRoomState extends State<LoginChallengeRoom> {
  TextEditingController codeController;
  String code;
  DatabaseReference dbRef =
  FirebaseDatabase.instance.reference().child('challenges');
  bool showLoadingProgress = false;
  @override
  void initState() {
    codeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Restaurant App",
      theme: ThemeData(primaryColor: Theme.of(context).primaryColor),
      home: Scaffold(
        backgroundColor: Color(0xFFF6F5FA),
        body: ModalProgressHUD(
          inAsyncCall: showLoadingProgress,
          progressIndicator: kCustomProgressIndicator,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        iconSize: 20.0,
                        padding: EdgeInsets.only(top: 10),
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
                    clipBehavior: Clip.none,
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
                            "Please Enter Challenge Code",
                            style:
                                TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  decoration: InputDecoration(
                                      labelText: "Code*",
                                      labelStyle: TextStyle(fontSize: 14.0),

                                  ),
                                  controller: codeController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 7,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              FocusScopeNode currentFocus = FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              onLoginToChallenge();
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
                                  "Enter To Match",
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
            ),
          ),
        ),
      ),
    );
  }

  onLoginToChallenge() async{
    if (checkCode()) {
      getCodeChallenge();
    } else {
      // pass
    }
  }

  bool checkCode() {
    code=codeController.text;
    if(code.length == 0){
      print('length :${code.length}');
      return false;
    }
    if(code.length < 7){
      print('length 7:${code.length}');
      return false;
    }
    return true;
  }

  getCodeChallenge() async{
    print(code);
    showLoadingProgress = true;
    setState(() {});
    try {
      String city,date,time;
      int referralCode;
      bool isActive;
      await dbRef.child('DQb2QE1IezQtx2yrxg4sNqnXP5q2').child(code).once().then((value) {
        print('---------------------------------------------');
        city = value.value['city'];
        time = value.value['time'];
        date = value.value['date'];
        isActive = value.value['isActive'];
        referralCode = value.value['referralCode'];
      });
      showLoadingProgress = false;
      setState(() {});
      if(isActive == true) {
        Provider.of<Notifier>(context, listen: false).changeLocation(city);
        Navigator.popAndPushNamed(
          context,
          InfoChallenge.id,
          arguments: {
            'city': city,
            'time': time,
            'date': date,
            'referralCode': referralCode,
          },
        );
      }else{
        print('Game no Active');
      }
    } catch (e) {
      showLoadingProgress = false;
      setState(() {});
      print('game not fund');
      // print('massege '+e.toString());
    }
  }
}
