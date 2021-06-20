import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_challenge_app/model/notifier.dart';
import 'package:restaurant_challenge_app/screens/challenge/ResturantList.dart';
import 'package:restaurant_challenge_app/screens/challenge/userScore.dart';
import 'package:restaurant_challenge_app/static_methods.dart';

class NavDrawer extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
              child: null,
            ),
            ListTile(
              onTap: (){
                Navigator.pushNamed(context, UserScore.id);
              },
              leading: Icon(
                Icons.support_agent,
                color: Colors.black,
              ),
              title: Text(
                'User Score',
              ),
            ),
            ListTile(

              leading: Icon(Icons.history_outlined, color: Colors.black),
              title: Text(
                'Restaurants Challenge',
              ),
              onTap: (){
                Navigator.pushNamed(context, RestaurantList.id);

              },
            ),

            ListTile(
              leading: Icon(
                Icons.support_agent,
                color: Colors.black,
              ),
              title: Text(
                'The results of this challenge',
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.history_outlined, color: Colors.black),
              title: Text(
                'Messages',
              ),
            ),
            Visibility(
              visible: Provider.of<Notifier>(context,listen: true).role=='Admin',
              child: ListTile(
                onTap: (){
                  StaticMethods.showErrorDialog(context: context, text: 'the referral code for this challenge is ${Provider.of<Notifier>(context).referral}');
                },
                leading: Icon(Icons.history_outlined, color: Colors.black),
                title: Text(
                  'Challenge Referral Code',
                ),
              ),

            ),
            ListTile(
              leading: Icon(Icons.person_outline, color: Colors.black),
              title: Text(
                'LogOut',
              ),
              onTap: () {_auth.signOut();},
            ),
          ],
        ),
      ),
    );
  }

}
