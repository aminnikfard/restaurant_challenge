import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_challenge_app/componnent/ticket_widget.dart';
import 'package:restaurant_challenge_app/constants.dart';
import 'package:restaurant_challenge_app/model/notifier.dart';
import 'package:restaurant_challenge_app/screens/game/game_screen.dart';
import 'package:restaurant_challenge_app/screens/game/list_restaurant_screen.dart';
import 'package:restaurant_challenge_app/screens/login_to_challenge_room.dart';

class InfoChallenge extends StatefulWidget {
  static String id = 'info_challenge_screen';

  const InfoChallenge({Key key}) : super(key: key);

  @override
  _InfoChallengeState createState() => _InfoChallengeState();
}

class _InfoChallengeState extends State<InfoChallenge> {
  Size size;
  Map args;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    args = ModalRoute.of(context).settings.arguments;
    String date = args['date'].substring(0, 10);
    int rate = Provider.of<Notifier>(context, listen: true).rate;
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
              child: FlutterTicketWidget(
                width: size.width / 1.15,
                height: size.height / 1.38,
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
                                  border:
                                  Border.all(width: 1.0, color: Colors.green),
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
                                  'Game Manufacturer Name', 'Ilona', '', ''),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 12.0, right: 40.0),
                              child: ticketDetailsWidget(
                                  'Game Name', '${args['challengeName']}', '', ''),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 12.0, right: 40.0),
                              child: ticketDetailsWidget(
                                  'Date', '$date', 'Time', '${args['time']}'),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 12.0, right: 40.0),
                              child: ticketDetailsWidget(
                                  'City', '${args['city']}', 'Score', '0'),
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
                        child: Provider.of<Notifier>(context, listen: false)
                            .isSelected ==
                            false
                            ? Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Color(0xFFFF5715), width: 0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      )),
                                  builder: (context) {
                                    return ListRestaurant();
                                  });
                            },
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            title: Text(
                              'No Select Restaurant',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                  "assets/icons/pizza.png"), // no matter how big it is, it won't overflow
                            ),
                          ),
                        )
                            : Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Color(0xFFFF5715), width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      )),
                                  builder: (context) {
                                    return ListRestaurant();
                                  });
                            },
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
                                                "${Provider.of<Notifier>(context, listen: true).img}"))),
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
                                          "${Provider.of<Notifier>(context, listen: true).name}",
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
                                          "${Provider.of<Notifier>(context, listen: true).address}",
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
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (Provider.of<Notifier>(context,
                                      listen: false)
                                      .isSelected) {
                                    insertToDb();
                                    print('true');
                                  } else {
                                    print('false');
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFF5715),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Participation',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 75.0, right: 75.0),
                        child: Center(
                          child: Text(
                            'ReferralCode: ${args['referralCode']}',
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
            ),
          ],
        ),
      ),
    );
  }

  insertToDb() {
    final DatabaseReference dbRef = FirebaseDatabase.instance
        .reference()
        .child('challenges')
        .child(args['referralCode'])
        .child('users')
        .child(auth.currentUser.uid);
    dbRef.update({
      'name': auth.currentUser.displayName,
      'id': auth.currentUser.uid,
      'score': 0,
      'isPlay': false,
      'restaurant': {
        'restaurantName': Provider.of<Notifier>(context, listen: false).name,
        'restaurantImg': Provider.of<Notifier>(context, listen: false).img,
        'restaurantRate': Provider.of<Notifier>(context, listen: false).rate,
        'restaurantAddress':
            Provider.of<Notifier>(context, listen: false).address,
        'restaurantId': Provider.of<Notifier>(context, listen: false).id,
      }
    });
    Provider.of<Notifier>(context, listen: false).changeRole('user');
    Navigator.pushNamed(context, GameScreen.id);
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
