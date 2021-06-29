import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_challenge_app/model/notifier.dart';
import 'package:restaurant_challenge_app/model/users.dart';
import 'package:restaurant_challenge_app/screens/auth_screen.dart';
import 'package:restaurant_challenge_app/screens/challenge/ResturantList.dart';
import 'package:restaurant_challenge_app/screens/challenge/userScore.dart';
import 'package:social_share/social_share.dart';
import '../../constants.dart';

class ChallengeManagement extends StatefulWidget {
  static String id = 'ChallengeManagement';

  @override
  _ChallengeManagementState createState() => _ChallengeManagementState();
}

class _ChallengeManagementState extends State<ChallengeManagement> {
  final DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child('challenges');

  // final _auth = FirebaseAuth.instance;

  final double rate = 6;

  String referral;

  Map args;

  String date;

  @override
  void initState() {
    // TODO: implement initState
    stream(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    referral = Provider.of<Notifier>(context, listen: false).referral;
    Size size = MediaQuery.of(context).size;
    args = ModalRoute.of(context).settings.arguments;
    date = args['date'].substring(0, 10);
    String isStartPlay =
        Provider.of<Notifier>(context, listen: true).isStartPlay == true
            ? 'Yes'
            : 'No';
    String isEndPlay =
        Provider.of<Notifier>(context, listen: true).isEndPlay == true
            ? 'Yes'
            : 'No';
    return Scaffold(
      floatingActionButton: Provider.of<Notifier>(context, listen: true)
              .isActive
          ? FloatingActionButton(
              child: Icon(
                Icons.stop_circle_outlined,
                color: kPrimaryColor,
                size: 45,
              ),
              backgroundColor: kColorWhite,
              onPressed: () {
                changeStatus(context,
                    !Provider.of<Notifier>(context, listen: false).isActive);
              },
            )
          : SizedBox(),
      appBar: AppBar(
        title: Text('Challenge'),
        centerTitle: true,
        elevation: 0,
        actions: [
          if (Provider.of<Notifier>(context, listen: true).isActive) ...{
            IconButton(
              iconSize: 20.0,
              icon: Icon(
                Icons.stop_circle_outlined,
              ),
              onPressed: () {
                changeStatus(context,
                    !Provider.of<Notifier>(context, listen: false).isActive);
                // Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
          },
          IconButton(
            iconSize: 20.0,
            icon: Icon(Icons.add_alert),
            onPressed: () {
              // Navigator.pushNamed(context, LoginScreen.id);
            },
          ),
        ],
        leading: IconButton(
          iconSize: 20.0,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.popAndPushNamed(context, AuthScreen.id);
          },
        ),
      ),
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 5.0 / 2,
                ),
                height: size.height / 2.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/icons/cheat-day.png"))),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, right: 40.0),
                                  child: ticketDetailsWidget('Game Name',
                                      '${args['challengeName']}', '', ''),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, right: 40.0),
                                  child: ticketDetailsWidget('Date', '$date',
                                      'Time', '${args['time']}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, right: 40.0),
                                  child: ticketDetailsWidget(
                                      'City',
                                      '${args['city']}',
                                      'Users',
                                      Provider.of<Notifier>(context,
                                              listen: true)
                                          .users
                                          .length
                                          .toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, right: 40.0),
                                  child: ticketDetailsWidget('Play Game',
                                      '$isStartPlay', 'End Game', '$isEndPlay'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color(0xFFFF5715),
                            width: 2,
                          ),
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
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage( Provider.of<Notifier>(context, listen: true).winnerRestaurant.restaurantImg),
                                ),
                                // decoration: BoxDecoration(
                                //     image: DecorationImage(
                                //         image: NetworkImage( Provider.of<Notifier>(context, listen: true).winnerRestaurant.restaurantImg))),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      Provider.of<Notifier>(context, listen: true).winnerRestaurant.restaurantName,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        for (var i = 1; i < rate; i++)...{
                                          if(i <= Provider
                                              .of<Notifier>(
                                              context, listen: true)
                                              .winnerRestaurant
                                              .restaurantRate)...{

                                            Icon(
                                              Icons.star_rate_sharp,
                                              size: 18,
                                              color: Colors.orange,
                                            ),
                                          },
                                          if(i > Provider
                                              .of<Notifier>(
                                              context, listen: true)
                                              .winnerRestaurant
                                              .restaurantRate)...{

                                            Icon(
                                              Icons.star_border_rounded,
                                              size: 18,
                                              color: Colors.orange,
                                            ),
                                          }
                                        }
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      Provider.of<Notifier>(context, listen: true).winnerRestaurant.restaurantAddress,
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Icon(Icons.visibility),
                                    Text(Provider.of<Notifier>(context, listen: true).winnerReview.toString()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Referral Code:',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                Provider.of<Notifier>(context, listen: true)
                                    .referral
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          socialIcon(
                              context, Icons.copy, Colors.black45, "copy"),
                          socialIcon(context, FontAwesomeIcons.sms,
                              Colors.black87, "sms"),
                          socialIcon(context, FontAwesomeIcons.telegram,
                              Colors.blueAccent, "telegram"),
                          socialIcon(context, FontAwesomeIcons.whatsapp,
                              Colors.green, "whatsapp"),
                          socialIcon(context, FontAwesomeIcons.twitter,
                              Colors.blueAccent, "twitter"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                        builder: (context) {
                          return UserScore();
                        });
                  },
                  child: list(context, "rating", "Users")),
              InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                        builder: (context) {
                          return RestaurantList();
                        });
                  },
                  child: list(context, "restaurant", "Restaurant")),
              // stream(context),
            ],
          ),
        ),
      ),
    );
  }

  changeStatus(BuildContext context, bool isActive) async {
    print('kkkk');
    try {
      DatabaseReference databaseRef =
          dbRef.child(Provider.of<Notifier>(context, listen: false).referral);

      await databaseRef.update({
        'isActive': isActive,
        'isEndPlay': true,
      });
      Provider.of<Notifier>(context, listen: false).changeIsActive(isActive);
      List<int> scoreRestaurant = [];
      for (int i = 0;
          i <
              Provider.of<Notifier>(context, listen: false)
                  .uniqueRestaurantList
                  .length;
          i++) {
        scoreRestaurant.add(1);
        for (int j = 0;
            j <
                Provider.of<Notifier>(context, listen: false)
                    .restaurantList
                    .length;
            j++) {
          if (Provider.of<Notifier>(context, listen: false)
                  .uniqueRestaurantList
                  .elementAt(i)
                  .restaurantId ==
              Provider.of<Notifier>(context, listen: false)
                  .users
                  .elementAt(j)
                  .restaurant
                  .restaurantId) {
            scoreRestaurant[i] += Provider.of<Notifier>(context, listen: false)
                    .users
                    .elementAt(j)
                    .score *
                (Provider.of<Notifier>(context, listen: false)
                        .countRestaurantList
                        .elementAt(i) *
                    Provider.of<Notifier>(context, listen: false)
                        .countRestaurantList
                        .elementAt(i));
          }
        }
      }
      for (int j = 0; j < scoreRestaurant.length; j++) {
        if (scoreRestaurant.elementAt(0) < scoreRestaurant.elementAt(j)) {
          int a = scoreRestaurant.elementAt(j);
          scoreRestaurant.remove(j);
          scoreRestaurant.insert(0, a);

          Restaurant b = Provider.of<Notifier>(context, listen: false)
              .uniqueRestaurantList
              .elementAt(j);
          Provider.of<Notifier>(context, listen: false)
              .uniqueRestaurantList
              .remove(j);
          Provider.of<Notifier>(context, listen: false)
              .uniqueRestaurantList
              .insert(0, b);
          int c = Provider.of<Notifier>(context, listen: false)
              .countRestaurantList
              .elementAt(j);
          Provider.of<Notifier>(context, listen: false)
              .countRestaurantList
              .remove(j);
          Provider.of<Notifier>(context, listen: false)
              .countRestaurantList
              .insert(0, c);
        }
      }
      print(Provider.of<Notifier>(context, listen: false).uniqueRestaurantList);
      print(scoreRestaurant);

      Provider.of<Notifier>(context, listen: false).changeWinnerRestaurant(
          Provider.of<Notifier>(context, listen: false)
              .uniqueRestaurantList
              .elementAt(0));
      Provider.of<Notifier>(context, listen: false).changeWinnerReview(
          Provider.of<Notifier>(context, listen: false)
              .countRestaurantList
              .elementAt(0));
      Provider.of<Notifier>(context, listen: false)
          .changeWinnerRestaurantScore(scoreRestaurant.elementAt(0));
      // scoreRestaurant.sort();
      databaseRef.child('winner').update({
        'restaurantName': Provider.of<Notifier>(context, listen: false)
            .winnerRestaurant
            .restaurantName,
        'restaurantImg': Provider.of<Notifier>(context, listen: false)
            .winnerRestaurant
            .restaurantImg,
        'restaurantRate': Provider.of<Notifier>(context, listen: false)
            .winnerRestaurant
            .restaurantRate,
        'restaurantAddress': Provider.of<Notifier>(context, listen: false)
            .winnerRestaurant
            .restaurantAddress,
        'restaurantId': Provider.of<Notifier>(context, listen: false)
            .winnerRestaurant
            .restaurantId,
        'restaurantScore':
            Provider.of<Notifier>(context, listen: false).winnerRestaurantScore,
        'restaurantReview':
            Provider.of<Notifier>(context, listen: false).winnerReview
      });
      print('eeeeeeeeee');
    } catch (e) {
      print('aaaaaa');

      print(e);
    }
  }

  GestureDetector socialIcon(
      BuildContext context, IconData iconSrc, Color color, String nameIcon) {
    return GestureDetector(
      onTap: () async {
        String massage =
            "You have been invited to the challenge ${args['challengeName']} this is a challenge between my friends during the day $date and at the hour ${args['time']} and you can participate in this challenge through the following code.\nYour invitation code: $referral";
        if (nameIcon == "copy") {
          SocialShare.copyToClipboard(
            massage,
          ).then((data) {
            print(data);
          });
        } else if (nameIcon == "sms") {
          SocialShare.shareSms(
            massage,
          ).then((data) {
            print(data);
          });
        } else if (nameIcon == "telegram") {
          SocialShare.shareTelegram(
            massage,
          ).then((data) {
            print(data);
          });
        } else if (nameIcon == "whatsapp") {
          SocialShare.shareWhatsapp(
            massage,
          ).then((data) {
            print(data);
          });
        } else if (nameIcon == "twitter") {
          SocialShare.shareTwitter(
            massage,
          ).then((data) {
            print(data);
          });
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconSrc,
          color: color,
          size: 25,
        ),
      ),
    );
  }

  Container list(BuildContext context, String img, String title) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 5.0 / 2,
      ),
      // color: Colors.blueAccent,
      height: 100,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          // Those are our background
          Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              // color: itemIndex.isEven ? kBlueColor : kSecondaryColor,
              // boxShadow: [kDefaultShadow],
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/icons/$img.png"))),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$title",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.list_alt_rounded),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget ticketDetailsWidget(String firstTitle, String firstDesc,
      String secondTitle, String secondDesc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 14.0),
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
                padding: const EdgeInsets.only(top: 6.0),
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
                padding: const EdgeInsets.only(top: 6.0),
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

  stream(BuildContext context) {
    dbRef
        .child(Provider.of<Notifier>(context, listen: false).referral)
        .once()
        .then((value) {
      List<Users> users = [];
      List<Restaurant> restaurants = [];
      Map map = value.value;

      Provider.of<Notifier>(context, listen: false)
          .changeIsStartPlay(map['isStartPlay']);
      Provider.of<Notifier>(context, listen: false)
          .changeIsActive(map['isActive']);

      Provider.of<Notifier>(context, listen: false)
          .changeIsEndPlay(map['isEndPlay']);
      if(map['winner']!=null){
        Restaurant restaurant = Restaurant(
            restaurantAddress: map['winner']['restaurantAddress'],
            restaurantImg: map['winner']['restaurantImg'],
            restaurantName: map['winner']['restaurantName'],
            restaurantRate: map['winner']['restaurantRate'],
            restaurantId: map['winner']['restaurantId']);
        Provider.of<Notifier>(context, listen: false).changeWinnerRestaurant(restaurant);
        Provider.of<Notifier>(context, listen: false).changeWinnerRestaurantScore(map['winner']['restaurantScore']);
        Provider.of<Notifier>(context, listen: false).changeWinnerReview(map['winner']['restaurantReview']);


      }
      if (map['users'] != null) {
        for (Map each in map['users'].values) {
          Restaurant restaurant = Restaurant(
              restaurantAddress: each['restaurant']['restaurantAddress'],
              restaurantImg: each['restaurant']['restaurantImg'],
              restaurantName: each['restaurant']['restaurantName'],
              restaurantRate: each['restaurant']['restaurantRate'],
              restaurantId: each['restaurant']['restaurantId']);
          restaurants.add(restaurant);

          Users user = Users(
              isPlay: each['isPlay'],
              restaurant: restaurant,
              score: each['score'],
              userName: each['name'],
              id: each['id']);
          users.add(user);
        }
      }
      Provider.of<Notifier>(context, listen: false).changeUsersList(users);
      Provider.of<Notifier>(context, listen: false)
          .changeRestaurantList(restaurants);
      List<Restaurant> uniqueRestaurant = [];
      List<int> countRestaurant = [];
      for (int i = 0;
          i <
              Provider.of<Notifier>(context, listen: false)
                  .restaurantList
                  .length;
          i++) {
        bool check = false;

        for (int j = 0; j < uniqueRestaurant.length; j++) {
          if (uniqueRestaurant.elementAt(j).restaurantId ==
              Provider.of<Notifier>(context, listen: false)
                  .restaurantList
                  .elementAt(i)
                  .restaurantId) {
            check = true;
            break;
          }
        }
        if (check) {
          print('ok');
        } else {
          uniqueRestaurant.add(Provider.of<Notifier>(context, listen: false)
              .restaurantList
              .elementAt(i));
        }
      }
      for (int i = 0; i < uniqueRestaurant.length; i++) {
        countRestaurant.add(0);
        for (int j = 0;
            j <
                Provider.of<Notifier>(context, listen: false)
                    .restaurantList
                    .length;
            j++) {
          if (uniqueRestaurant.elementAt(i).restaurantId ==
              Provider.of<Notifier>(context, listen: false)
                  .restaurantList
                  .elementAt(j)
                  .restaurantId) {
            countRestaurant[i]++;
          }
        }
      }

      Provider.of<Notifier>(context, listen: false)
          .changeUniqueRestaurantList(uniqueRestaurant);
      Provider.of<Notifier>(context, listen: false)
          .changeCountRestaurantList(countRestaurant);
    });
  }
}
