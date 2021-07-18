import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_challenge_app/model/notifier.dart';
import 'package:restaurant_challenge_app/screens/game/result_gmae_screen.dart';

class GameScreen extends StatefulWidget {
  static String id = 'game_screen';

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FeatureDiscovery.withProvider(
          persistenceProvider: NoPersistenceProvider(),
          child: Game(),
        ),
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
  final player = AudioPlayer();


  @override
  void initState() {
    super.initState();
    _init();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FeatureDiscovery.discoverFeatures(context,
          <String>[
            'feature1',
            'feature2',
            'feature3',
          ]
      );
    });
  }

  void _init() async {
    var duration = await player.setAsset('assets/audio.mp3');
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    double f = size.height / 470;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background-game.jpg'),
                fit: BoxFit.fill),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.width / 9 ),
                      child: DescribedFeatureOverlay(
                        featureId: 'feature2',
                        targetColor: Colors.white,
                        textColor: Colors.white,
                        backgroundColor: Theme.of(context).primaryColor,
                        contentLocation: ContentLocation.below,
                        title: Text(
                          'Countdown timer',
                          style: TextStyle(fontSize: 30.0),
                        ),
                        pulseDuration: Duration(seconds: 2),
                        enablePulsingAnimation: true,
                        overflowMode: OverflowMode.extendBackground,
                        openDuration: Duration(seconds: 2),
                        description: Text('In this section you can see \nthe remaining time of the game.',style: TextStyle(fontSize: 17.0),),
                        tapTarget: CircularCountDownTimer(
                          duration: 30,
                          initialDuration: 0,
                          controller: CountDownController(),
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.height / 5,
                          ringColor: Colors.grey[300],
                          ringGradient: null,
                          fillColor: Color.fromRGBO(242,223,55, 0.90),
                          fillGradient: null,
                          backgroundColor: Color.fromRGBO(232,52,70, 0.90),
                          backgroundGradient: null,
                          strokeWidth: 8.0,
                          strokeCap: StrokeCap.round,
                          textStyle: TextStyle(
                              fontSize: 17.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        child:
                        startTimer == true
                            ? CircularCountDownTimer(
                          duration: 30,
                          initialDuration: 0,
                          controller: CountDownController(),
                          width: 75,
                          height: 75,
                          ringColor: Colors.grey[300],
                          ringGradient: null,
                          fillColor: Color.fromRGBO(248, 92, 44, 0.99),
                          fillGradient: null,
                          backgroundColor: Color.fromRGBO(
                              180, 6, 22, 0.90),
                          backgroundGradient: null,
                          strokeWidth: 8.0,
                          strokeCap: StrokeCap.round,
                          textStyle: TextStyle(
                              fontSize: 17.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textFormat: CountdownTextFormat.S,
                          isReverse: true,
                          isReverseAnimation: false,
                          isTimerTextShown: true,
                          autoStart: true,
                          onComplete: () {
                            insertScore();
                            end = true;
                          },
                        )
                            : Expanded(child: SizedBox()),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                        top: (size.height / 2) - sum,
                      ),
                      child: Lottie.asset('assets/53947-sushi.json',
                          height: 170, width: 170)),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.width / 9 ),
                      child: DescribedFeatureOverlay(
                        featureId: 'feature3',
                        targetColor: Colors.white,
                        textColor: Colors.white,
                        backgroundColor: Theme.of(context).primaryColor,
                        contentLocation: ContentLocation.below,
                        title: Text(
                          'Points taken',
                          style: TextStyle(fontSize: 30.0),
                        ),
                        pulseDuration: Duration(seconds: 2),
                        enablePulsingAnimation: true,
                        overflowMode: OverflowMode.extendBackground,
                        openDuration: Duration(seconds: 2),
                        description: Text('In this section, you can see the points collected in the game.',style: TextStyle(fontSize: 17.0)),
                        tapTarget: CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Color.fromRGBO(37,100,138, 0.99),
                          child: Text(
                            dSum.toString(),
                            style: TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Color.fromRGBO(37,100,138, 0.99),
                          child: Text(
                            dSum.toString(),
                            style: TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: SizedBox()),
              DescribedFeatureOverlay(
                featureId: 'feature1',
                targetColor: Colors.white,
                textColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                contentLocation: ContentLocation.above,
                title: Text(
                  'On Tap Here',
                  style: TextStyle(fontSize: 30.0),
                ),
                pulseDuration: Duration(seconds: 2),
                enablePulsingAnimation: true,
                overflowMode: OverflowMode.extendBackground,
                openDuration: Duration(seconds: 2),
                description: Text('Tap here repeatedly to earn points and move the food up to the plates',style: TextStyle(fontSize: 17.0)),
                tapTarget: Container(
                  child: Lottie.asset(
                      'assets/19611-ration-food-transition.json',
                      height: 200,
                      width: 200),
                ),
                child: CircleAvatar(
                  radius: 50,
                  child: InkWell(
                    onTap: () {
                      player.play();
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
      player.stop();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ResultGama()));
    } catch (e) {
      print(e);
    }
  }
}
