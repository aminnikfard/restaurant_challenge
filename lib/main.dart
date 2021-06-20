import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_challenge_app/screens/auth_screen.dart';
import 'package:restaurant_challenge_app/screens/challenge/ResturantList.dart';
import 'package:restaurant_challenge_app/screens/challenge/manage.dart';
import 'package:restaurant_challenge_app/screens/game/game.dart';
import 'package:restaurant_challenge_app/screens/create_challenge.dart';
import 'package:restaurant_challenge_app/screens/game/game_screen.dart';
import 'package:restaurant_challenge_app/screens/info_challenge_screen.dart';
import 'package:restaurant_challenge_app/screens/login_screen.dart';
import 'package:restaurant_challenge_app/screens/login_to_challenge_room.dart';
import 'package:restaurant_challenge_app/screens/match_screen.dart';
import 'package:restaurant_challenge_app/screens/register_email_screen.dart';
import 'package:restaurant_challenge_app/screens/register_phone_screen.dart';

import 'model/field_notifier.dart';
import 'model/notifier.dart';
import 'screens/challenge/userScore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FieldNotifier()),
        ChangeNotifierProvider(create: (context) => Notifier()),
      ],
      child: MyApp(),
    ),
  );

  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: ThemeData(
        primaryColor: Color(0xFFFF5715),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginScreen.id,
      routes: {
        RegisterEmailScreen.id: (context) => RegisterEmailScreen(),
        AuthScreen.id: (context) => AuthScreen(),
        ChallengeScreen.id: (context) => ChallengeScreen(),
        RegisterPhoneScreen.id: (context) => RegisterPhoneScreen(),
        LoginChallengeRoom.id: (context) => LoginChallengeRoom(),
        MatchScreen.id: (context) => MatchScreen(),
        GameScreen.id: (context) => GameScreen(),
        ChallengeManagement.id: (context) => ChallengeManagement(),
        InfoChallenge.id: (context) => InfoChallenge(),
        UserScore.id: (context) => UserScore(),
        LoginScreen.id: (context) => LoginScreen(),
        RestaurantList.id: (context) => RestaurantList(),
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
