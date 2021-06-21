import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_challenge_app/model/notifier.dart';
import 'package:restaurant_challenge_app/screens/challenge/list_challenge.dart';
import 'package:restaurant_challenge_app/screens/login_screen.dart';
import 'package:restaurant_challenge_app/screens/login_to_challenge_room.dart';
import 'package:restaurant_challenge_app/screens/register_phone_screen.dart';
import 'package:restaurant_challenge_app/static_methods.dart';

import 'challenge/manage.dart';
import 'challenge/create_challenge.dart';
import 'game/game.dart';

class AuthScreen extends StatefulWidget {
  static String id = 'auth_screen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  // @override
  // void initState() {
  //   if(_auth.currentUser!=null){
  //     Future.delayed(Duration.zero, () async {      Navigator.pushNamed(context, ChallengeManagement.id);
  //     });
  //   }
  //   super.initState();
  // }
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
                  height: 320.0,
                ),
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
                    // onAdminPress();
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => ChallengeScreen()));
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
                SizedBox(height: 10.0,),
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
                SizedBox(height: 10.0,),
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
                SizedBox(height: 10.0,),
                GestureDetector(
                  onTap: () {
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Text(
                        "Now! Quick Login User Touch ID",
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Icon(
                        Icons.fingerprint,
                        color: Colors.white,
                        size: 70.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        "User Touch ID",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> checkChallenge() async {
    DatabaseReference dbRef =
        FirebaseDatabase.instance.reference().child('challenges');
    DataSnapshot snapshot = await dbRef
        .orderByChild('filter')
        .startAt('${_auth.currentUser.uid}_true')
        .endAt('${_auth.currentUser.uid}_true\uf8ff')
        .once();
    if (snapshot.value == null) {
      print("Item doesn't exist ");
      return false;
    } else {
      print("Item exists ");
      return true;
    }
  }

  onAdminPress()async{
    bool check=await checkChallenge();
    if(check){
      Provider.of<Notifier>(context, listen: false).changeRole('Admin');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ChallengeManagement()));
    }
    else{
      StaticMethods.showErrorDialog(context: context, text: 'you dont have active challenge ');
    }
  }


}
