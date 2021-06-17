import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GameScreen extends StatefulWidget {
  static String id = 'game_screen';

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  final DatabaseReference dbRef =
  FirebaseDatabase.instance.reference().child('challenges').child('uid').child('users').child('uid');
  Size size;
  int dSum = 0;
  bool end = false;
  double sum = 0;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    double f = size.height / 470;
    return WillPopScope(
      onWillPop:()=> Future.value(false),
      child: Scaffold(
        appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back_ios_sharp), onPressed: (){insertScore();}),),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {insertScore();Navigator.pop(context);},
        // ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background-game.jpg'), fit: BoxFit.fill),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  // height: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: SizedBox()),
                      CircularCountDownTimer(
                        duration: 30,
                        initialDuration: 0,
                        controller: CountDownController(),
                        width: MediaQuery.of(context).size.width / 6,
                        height: MediaQuery.of(context).size.height / 5,
                        ringColor: Colors.grey[300],
                        ringGradient: null,
                        fillColor: Color.fromRGBO(252,58,81, 1),
                        fillGradient: null,
                        backgroundColor: Color.fromRGBO(245,179,73, 1),
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
                        onStart: () {
                          print('Countdown Started');
                        },
                        onComplete: () {
                          end = true;
                        },
                      ),

                      Expanded(child: SizedBox()),
                      Container(
                          margin: EdgeInsets.only(
                            top: (size.height / 2) - sum,
                          ),
                          // child: Image.asset('assets/images/ball.jpg',height: 150
                          child: Lottie.asset('assets/4414-bouncy-basketball.json',
                              height: 250, width: 250)),
                      Expanded(child: SizedBox()),
                      Container(
                        margin: EdgeInsets.only(
                          top: 60,
                        ),
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundColor: Color.fromRGBO(244,93,76, 1),
                          child: Text(
                            dSum.toString(),
                            style: TextStyle(fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),

                      Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              InkWell(
                onTap: () {
                  if (!end) {
                    dSum += 2;
                    sum += f;
                    setState(() {});
                    print(sum);
                  }
                  else{
                    insertScore();
                  }
                },
                child: CircleAvatar(
                  radius: 53,
                  backgroundImage: AssetImage(
                    'assets/images/restaurant.jpg',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  insertScore()async{
    try {
      // DatabaseReference databaseRef = dbRef.push();
      await dbRef.set({
        'isPlay':true,
        'name': 'name',
        'uid': 'uid',
        'restaurant': 'restaurant',
        'score':dSum,
      });
    } catch (e) {
      print(e);
    }
  }


}
