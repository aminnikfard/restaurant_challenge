import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_challenge_app/model/notifier.dart';
import 'package:restaurant_challenge_app/screens/game/result_gmae_screen.dart';
import 'package:showcaseview/showcaseview.dart';

class GameScreen extends StatefulWidget {
  static String id = 'game_screen';

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowCaseWidget(
        onStart: (index, key) {
          print('onStart: $index, $key');
        },
        onComplete: (index, key) {
          print('onComplete: $index, $key');
          if (index == 4)
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
                .copyWith(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white));
        },
        builder: Builder(builder: (context) => Game()),
        autoPlay: false,
        autoPlayDelay: Duration(seconds: 3),
        autoPlayLockEnable: false,
      ),
    );
  }
}

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final DatabaseReference dbRef =
  FirebaseDatabase.instance.reference().child('challenges');
  Size size;
  int dSum = 0;
  bool end = false;
  double sum = 0;
  bool startTimer = false;

  GlobalKey _one = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ShowCaseWidget.of(context)
            .startShowCase([_one,]));
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    double f = size.height / 470;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: SafeArea(
          child: InkWell(
            onTap: () {
              // startTimer = true;
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background-game.jpg'),
                    fit: BoxFit.fill),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      // height: 100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: SizedBox()),
                          if (startTimer == true) ...[
                            CircularCountDownTimer(
                              duration: 30,
                              initialDuration: 0,
                              controller: CountDownController(),
                              width: MediaQuery.of(context).size.width / 7,
                              height: MediaQuery.of(context).size.height / 7,
                              ringColor: Colors.grey[300],
                              ringGradient: null,
                              fillColor: Color.fromRGBO(242,223,55, 0.90),
                              fillGradient: null,
                              backgroundColor: Color.fromRGBO(232,52,70, 0.90),
                              backgroundGradient: null,
                              strokeWidth: 8.0,
                              strokeCap: StrokeCap.round,
                              textStyle: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textFormat: CountdownTextFormat.S,
                              isReverse: true,
                              isReverseAnimation: false,
                              isTimerTextShown: true,
                              autoStart: true,
                              onStart: () {},
                              onComplete: () {
                                insertScore();
                                end = true;
                              },
                            ),
                          ] else ...[
                            //pass,
                          ],
                          Expanded(child: SizedBox()),
                          // Expanded(child: SizedBox()),
                          // Expanded(child: SizedBox()),
                          Container(
                              margin: EdgeInsets.only(
                                top: (size.height / 2) - sum,
                              ),
                              child: Lottie.asset('assets/53947-sushi.json',
                                  height: 170, width: 170)),
                          Expanded(child: SizedBox()),
                          Container(
                            margin: EdgeInsets.only(
                              top: 25,
                            ),
                            child: CircleAvatar(
                              radius: 40.0,
                              backgroundColor: Color.fromRGBO(37,100,138, 0.90),
                              child: Text(
                                dSum.toString(),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  CircleAvatar(
                    radius: 50,
                    child: Showcase(
                      key: _one,
                      title: 'On Tap Here',
                      description: 'Earn Points With Each Tap',
                      contentPadding: EdgeInsets.all(10.0),
                      showcaseBackgroundColor: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      shapeBorder: CircleBorder(),
                      child: InkWell(
                        onTap: () {
                          startTimer = true;
                          if (!end) {
                            dSum += 2;
                            sum += f;
                            setState(() {});
                            print(sum);
                          } else {
                            insertScore();
                          }
                        },
                        child: Container(
                          child: Lottie.asset(
                              'assets/19611-ration-food-transition.json',
                              height: 200,
                              width: 200),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  insertScore() async {
    try {
      DatabaseReference databaseRef = dbRef
          .child(Provider.of<Notifier>(context, listen: false).referral)
          .child('users')
          .child(auth.currentUser.uid);
      await databaseRef.update({
        'isPlay': true,
        'score': dSum,
      });
    } catch (e) {
      print(e);
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ResultGama()));
  }
}
