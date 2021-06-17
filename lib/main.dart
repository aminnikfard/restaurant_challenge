import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_challenge_app/models/notifier.dart';
import 'package:restaurant_challenge_app/screens/auth_screen.dart';
import 'package:restaurant_challenge_app/screens/game_screen.dart';
import 'package:restaurant_challenge_app/screens/home_screen.dart';
import 'package:restaurant_challenge_app/screens/info_challenge_screen.dart';
import 'package:restaurant_challenge_app/screens/list_restaurant_screen.dart';
import 'package:restaurant_challenge_app/screens/login_to_challenge_room.dart';
import 'package:restaurant_challenge_app/screens/register_email_screen.dart';
import 'package:restaurant_challenge_app/screens/register_phone_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Notifier()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: ThemeData(
        primaryColor: Color(0xFFFC8C1B),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
<<<<<<< HEAD
      initialRoute: AuthScreen.id,
=======

      initialRoute: GameScreen.id,
>>>>>>> 560243ebf1753e61a7b08139dfa8366d0358ffe4
      routes: {
        RegisterEmailScreen.id: (context) => RegisterEmailScreen(),
        AuthScreen.id: (context) => AuthScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        RegisterPhoneScreen.id: (context) => RegisterPhoneScreen(),
        LoginChallengeRoom.id: (context) => LoginChallengeRoom(),
<<<<<<< HEAD
        InfoChallenge.id: (context) => InfoChallenge(),
        ListRestaurant.id: (context) => ListRestaurant(),
=======
        GameScreen.id: (context) => GameScreen(),

>>>>>>> 560243ebf1753e61a7b08139dfa8366d0358ffe4
      },
    );
  }
}

// class InitializerWidget extends StatefulWidget {
//   @override
//   _InitializerWidget createState() => _InitializerWidget();
// }
//
// class _InitializerWidget extends State<InitializerWidget> {
//   FirebaseAuth _auth;
//   User _user;
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _auth = FirebaseAuth.instance;
//     _user = _auth.currentUser;
//     isLoading = false;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           )
//         : _user == null
//             ? LoginScreen()
//             : HomeScreen();
//   }
// }
