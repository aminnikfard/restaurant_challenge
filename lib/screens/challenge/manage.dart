import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_challenge_app/model/notifier.dart';
import 'package:restaurant_challenge_app/model/users.dart';
import 'package:restaurant_challenge_app/screens/auth_screen.dart';
import 'package:restaurant_challenge_app/screens/challenge/ResturantList.dart';
import 'package:restaurant_challenge_app/screens/challenge/userScore.dart';
import 'package:flutter/services.dart';
import 'package:social_share/social_share.dart';
import '../../constants.dart';

class ChallengeManagement extends StatelessWidget {
  static String id = 'ChallengeManagement';
  final DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child('challenges');
  final _auth = FirebaseAuth.instance;
  final double rate = 5;
  String referral;
  Map args;
  String date;
  @override
  Widget build(BuildContext context) {
    referral=Provider.of<Notifier>(context, listen: true).referral;
    bool isPlay=Provider.of<Notifier>(context, listen: true).isStartPlay;
    Size size = MediaQuery.of(context).size;
    args = ModalRoute.of(context).settings.arguments;
    date = args['date'].substring(0, 10);
    String isStartPlay=Provider.of<Notifier>(context, listen: true).isStartPlay==true ? 'Yes' : 'No';
    String isEndPlay=Provider.of<Notifier>(context, listen: true).isEndPlay==true ? 'Yes' : 'No';
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isPlay
              ? Icons.play_circle_outline_rounded
              : Icons.pause_circle_outline_sharp ,
          color: kPrimaryColor,
          size: 45,
        ),
        backgroundColor: kColorWhite,
        onPressed: () {
          isPlay = !isPlay;
          changeStatus(context,isPlay);
        },
      ),
      appBar: AppBar(
        title: Text(
            'Challenge'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            iconSize: 20.0,
            icon: Icon(
              isPlay
                  ? Icons.play_circle_outline_rounded
                  : Icons.pause_circle_outline_sharp ,
            ),
            onPressed: () {
              isPlay = !isPlay;
              changeStatus(context,isPlay);
              // Navigator.pushNamed(context, LoginScreen.id);
            },
          ),
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
                                  child: ticketDetailsWidget(
                                      'Date', '$date', 'Time', '${args['time']}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, right: 40.0),
                                  child: ticketDetailsWidget(
                                      'City', '${args['city']}', 'Users', '0'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, right: 40.0),
                                  child: ticketDetailsWidget(
                                      'Play Game', '$isStartPlay',
                                      'End Game', '$isEndPlay'),
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
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/icons/pizza1.png"))),
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
                                      "Restaurant name unknown",
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
                                      "Restaurant address unknown",
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
                                    Text('review'),
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
                              Text('Referral Code:',style: TextStyle(fontSize: 12),),
                              Text(Provider.of<Notifier>(context, listen: true).referral.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                            ],
                          ),
                          socialIcon(context,Icons.copy,Colors.black45,"copy"),
                          socialIcon(context,FontAwesomeIcons.sms,Colors.black87,"sms"),
                          socialIcon(context,FontAwesomeIcons.telegram,Colors.blueAccent,"telegram"),
                          socialIcon(context,FontAwesomeIcons.whatsapp,Colors.green,"whatsapp"),
                          socialIcon(context,FontAwesomeIcons.twitter,Colors.blueAccent,"twitter"),
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
              stream(context),
            ],
          ),
        ),
      ),
    );
  }

  changeStatus(BuildContext context, bool isStart) async {
    print('kkkk');
    try {
      DatabaseReference databaseRef =
          dbRef.child(Provider.of<Notifier>(context, listen: false).referral);
      // DatabaseReference databaseRef = dbRef.push();
      // if (isStart) {
      //   await databaseRef.update({
      //     'isStartPlay': true,
      //   });
      //   Provider.of<Notifier>(context, listen: false)
      //       .changeIsStartPlay(isStart);
      // } else {
      //   await databaseRef.update({
      //     'isEndPlay': true,
      //   });
      //   Provider.of<Notifier>(context, listen: false).changeIsEndPlay(true);
      // }
      await databaseRef.update({
        'isStartPlay': isStart,
      });
      Provider.of<Notifier>(context, listen: false).changeIsStartPlay(isStart);
    } catch (e) {
      print(e);
    }
  }
  GestureDetector socialIcon(BuildContext context,IconData iconSrc,Color color,String nameIcon){
    return GestureDetector(
      onTap: () async{
        String massage="You have been invited to the challenge ${args['challengeName']} this is a challenge between my friends during the day $date and at the hour ${args['time']} and you can participate in this challenge through the following code.\nYour invitation code: $referral";
        if(nameIcon == "copy"){
          SocialShare.copyToClipboard(
            massage,
          ).then((data) {
            print(data);
          });
        }else if(nameIcon == "sms"){
          SocialShare.shareSms(
            massage,
          ).then((data) {
            print(data);
          });
        }else if(nameIcon == "telegram"){
          SocialShare.shareTelegram(
            massage,
          ).then((data) {
            print(data);
          });
        }else if(nameIcon == "whatsapp"){
          SocialShare.shareWhatsapp(
            massage,
          ).then((data) {
            print(data);
          });
        }else if(nameIcon == "twitter"){
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
  Widget stream(BuildContext context) {
    return StreamBuilder(
      stream: dbRef.child(Provider.of<Notifier>(context, listen: true).referral).onValue,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData && snapshot.data.snapshot.value != null) {
          List<Users> users = [];
          List<Restaurant> restaurants = [];
          Map map = snapshot.data.snapshot.value;

          Provider.of<Notifier>(context, listen: false)
              .changeIsStartPlay(map['isStartPlay']);

          Provider.of<Notifier>(context, listen: false)
              .changeIsEndPlay(map['isEndPlay']);

          if (map['users'] != null) {
            for (Map each in map['users'].values) {
              Restaurant restaurant = Restaurant(
                  restaurantAddress: each['restaurant']
                      ['restaurantAddress'],
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
          print('users');
          print(users);
          Provider.of<Notifier>(context, listen: false)
              .changeUsersList(users);
          Provider.of<Notifier>(context, listen: false)
              .changeRestaurantList(restaurants);
        }
        return Text('');
      },
    );
  }
}
