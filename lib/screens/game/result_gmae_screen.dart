import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_challenge_app/componnent/ticket_widget2.dart';
import 'package:restaurant_challenge_app/constants.dart';
import 'package:restaurant_challenge_app/model/notifier.dart';
import 'package:restaurant_challenge_app/screens/login_to_challenge_room.dart';

class ResultGama extends StatefulWidget {
  static String id = 'result_game_screen';

  const ResultGama({Key key}) : super(key: key);

  @override
  _ResultGamaState createState() => _ResultGamaState();
}

class _ResultGamaState extends State<ResultGama> {
  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child('challenges');
  FirebaseAuth auth = FirebaseAuth.instance;
  int score;
  String name;
  String challengeName, city, date, time,referralCode,restaurantName,restaurantImg,restaurantAddress;
  bool showLoadingProgress = false;

  Future<Map<dynamic, dynamic>> getDataGamePlayer() async {
    return await dbRef
        .child(Provider.of<Notifier>(context, listen: true).referral)
        .once()
        .then((data) {
      return data.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    iconSize: 20.0,
                    icon: Icon(Icons.arrow_back_ios),
                    color: kColorWhite,
                    onPressed: () {
                      Navigator.pushNamed(context, LoginChallengeRoom.id);
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: ModalProgressHUD(
                inAsyncCall: showLoadingProgress,
                progressIndicator: kCustomProgressIndicator,
                child: FutureBuilder(
                  future: getDataGamePlayer(),
                  builder: (BuildContext context, AsyncSnapshot snapShot) {
                    if (snapShot.hasData &&
                        snapShot.connectionState == ConnectionState.done) {
                      Map data = snapShot.data;
                      challengeName=data['challengeName'];
                      city=data['city'];
                      time=data['time'];
                      date=data['date'].substring(0, 10);
                      score = data['users'][auth.currentUser.uid]['score'];
                      name = data['users'][auth.currentUser.uid]['name'];
                      int rate = data['users'][auth.currentUser.uid]['restaurant']['restaurantRate'];
                      restaurantImg=data['users'][auth.currentUser.uid]['restaurant']['restaurantImg'];
                      restaurantName=data['users'][auth.currentUser.uid]['restaurant']['restaurantName'];
                      restaurantAddress=data['users'][auth.currentUser.uid]['restaurant']['restaurantAddress'];
                      return Center(
                        child: FlutterTicketWidget2(
                          width: size.width / 1.15,
                          height: size.height / 1.45,
                          isCornerRounded: true,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Container(
                                          width: 140.0,
                                          height: 25.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30.0),
                                            border: Border.all(
                                                width: 1.0, color: Colors.green),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Recreational Class',
                                              style: TextStyle(color: Colors.green),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 20.0),
                                          child: Text(
                                            'Invitation Ticket',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth: 44,
                                        minHeight: 44,
                                        maxWidth: 64,
                                        maxHeight: 64,
                                      ),
                                      child: Image.asset("assets/icons/fastfood.png",
                                          fit: BoxFit.cover),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(right: 40.0),
                                        child: ticketDetailsWidget(
                                            'Game Participant Name', '$name', '', ''),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 12.0, right: 40.0),
                                        child: ticketDetailsWidget(
                                            'Game Name', '$challengeName', '', ''),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 12.0, right: 40.0),
                                        child: ticketDetailsWidget(
                                            'Date', '$date', 'Time', '$time'),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 12.0, right: 40.0),
                                        child: ticketDetailsWidget(
                                            'City', '$city', 'Score', '$score'),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFFFF5715),
                                        blurRadius: 9.0,
                                      ),
                                    ],
                                  ),
                                  child: Card(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Color(0xFFFF5715), width: 1),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 5.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "$restaurantImg"
                                                          ))),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "$restaurantName",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          for (var i = 0; i < rate; i++)
                                                            Icon(
                                                              Icons.star_rate_rounded,
                                                              size: 18,
                                                              color: Colors.orange,
                                                            ),
                                                          for (var i = 5; i > rate; i--)
                                                            Icon(
                                                              Icons.star_border_rounded,
                                                              size: 18,
                                                              color: Colors.orange,
                                                            ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "$restaurantAddress",
                                                        style: TextStyle(fontSize: 10),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                ),
                                SizedBox(
                                  height: 45,
                                ),
                                Flex(
                                  direction: Axis.vertical,
                                  children: [
                                    MySeparator(color: Colors.grey),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Center(
                                    child: Text(
                                      'The result of the game: The game is not over yet',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 75.0, right: 75.0),
                                  child: Center(
                                    child: Text(
                                      'ReferralCode: ${Provider.of<Notifier>(context, listen: false).referral}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: kCustomProgressIndicator,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ticketDetailsWidget(String firstTitle, String firstDesc,
      String secondTitle, String secondDesc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                firstTitle,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  firstDesc,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                secondTitle,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  secondDesc,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
