import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Game extends StatefulWidget {
  static String id = 'test';

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {

  final DatabaseReference dbRef =
  FirebaseDatabase.instance.reference().child('challenges').child('uid').child('users').child('uid');
  Size size;
  int dSum = 0;
  bool end = false;
  double sum = 0;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    double f = size.height / 800;
    return WillPopScope(
      onWillPop:()=> Future.value(false),
      child: Scaffold(

        appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back_ios_sharp), onPressed: (){insertScore();}),),
        floatingActionButton: FloatingActionButton(
          onPressed: () {insertScore();Navigator.pop(context);},
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/back.jpg'), fit: BoxFit.fill),
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
                        fillColor: Colors.deepOrangeAccent[100],
                        fillGradient: null,
                        backgroundColor: Colors.orange[500],
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
                          child: Lottie.asset('assets/ball.json',
                              height: 100, width: 100)),
                      Expanded(child: SizedBox()),
                      Container(
                        margin: EdgeInsets.only(
                          top: 60,
                        ),
                        child: Text(
                          dSum.toString(),
                          style: TextStyle(fontSize: 20,
                              color: Colors.black),
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
                    dSum += 1;
                    sum += f;
                    setState(() {});
                    print(sum);
                  }
                  else{
                    insertScore();
                  }
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    'assets/images/resturant.jpg',
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
