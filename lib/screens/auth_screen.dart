import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_challenge_app/screens/challenge/list_challenge.dart';
import 'package:restaurant_challenge_app/screens/login_screen.dart';
import 'package:restaurant_challenge_app/screens/login_to_challenge_room.dart';
import 'challenge/create_challenge.dart';

class AuthScreen extends StatefulWidget {
  static String id = 'auth_screen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20.0),
            child: Column(
              children: <Widget>[
                Image(
                  image: AssetImage("assets/images/intro.png"),
                  height: 340.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginChallengeRoom()));
                      },
                      child: Container(
                        width: 150.0,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 1,
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5.0,
                                  offset: Offset(0, 2.0))
                            ]),
                        child: Center(
                          child: Text(
                            "Login To Game",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChallengeScreen()));
                      },
                      child: Container(
                        width: 150.0,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 1,
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5.0,
                                  offset: Offset(0, 2.0))
                            ]),
                        child: Center(
                          child: Text(
                            "Create Game",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],),
                SizedBox(height: 30.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                )),
                            builder: (context) {
                              return ListChallenge();
                            });
                      },
                      child: Container(
                        width: 150.0,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 1,
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5.0,
                                  offset: Offset(0, 2.0))
                            ]),
                        child: Center(
                          child: Text(
                            "Dashboard Game",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        _auth.signOut();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            LoginScreen.id, (Route<dynamic> route) => false);
                      },
                      child: Container(
                        width: 150.0,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 1,
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5.0,
                                  offset: Offset(0, 2.0))
                            ]),
                        child: Center(
                          child: Text(
                            "Logout",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
