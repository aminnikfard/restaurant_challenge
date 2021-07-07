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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image(
                  image: AssetImage("assets/images/intro.png"),
                  height: 340.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginChallengeRoom()));
                      },
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(26.0),
                          child: Column(
                            children: [
                              Icon(Icons.psychology,size: 50,),
                              SizedBox(height: 20,),
                              Text('Login To Game',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
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
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              Icon(Icons.add_business_rounded,size: 50,),
                              SizedBox(height: 20,),
                              Text(
                                "Create Game",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],),
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Icon(Icons.emoji_events,size: 50,),
                                SizedBox(height: 20,),
                                Text('Dashboard Game',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
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
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(27.0),
                          child: Column(
                            children: [
                              Icon(Icons.logout,size: 50,),
                              SizedBox(height: 20,),
                              Text(
                                "Logout",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
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
