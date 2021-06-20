import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_challenge_app/model/notifier.dart';
import 'package:restaurant_challenge_app/model/users.dart';
import 'package:restaurant_challenge_app/screens/game/game.dart';
import 'package:restaurant_challenge_app/screens/game/game_screen.dart';

import 'side_menu.dart';

class ChallengeManagement extends StatelessWidget {
  static String id = 'ChallengeManagement';
  final DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child('challenges');
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Challenge: ${Provider.of<Notifier>(context, listen: true).referral}'),
        centerTitle: true,
      ),
      drawer: NavDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              // height: 300,
              child: StreamBuilder(
                stream: Provider.of<Notifier>(context, listen: false).role ==
                        'user'
                    ? dbRef
                        .child(Provider.of<Notifier>(context, listen: false)
                            .referral)
                        .onValue
                    : dbRef
                        .orderByChild('filter')
                        .startAt('${_auth.currentUser.uid}_true')
                        .endAt('${_auth.currentUser.uid}_true\uf8ff')
                        .onValue,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data.snapshot.value != null) {
                    List<Users> users = [];
                    List<Restaurant> restaurants = [];
                    if (Provider.of<Notifier>(context, listen: false).role ==
                        'user') {
                      Map map = snapshot.data.snapshot.value;
                      Provider.of<Notifier>(context, listen: false)
                          .changeChallengeName(map['challengeName'].toString());

                      Provider.of<Notifier>(context, listen: false)
                          .changeIsStartPlay(map['isStartPlay']);
                      Provider.of<Notifier>(context, listen: false)
                          .changeIsEndPlay(map['isEndPlay']);

                      print('aaaa');
                      Provider.of<Notifier>(context, listen: false)
                          .changeReferral(map['referralCode'].toString());
                      print('ddddddddddd');

                      if (map['users'] != null) {
                        int counter=0;
                        for (Map each in map['users'].values) {
                          Restaurant restaurant = Restaurant(
                              restaurantAddress: each['restaurant']
                                  ['restaurantAddress'],
                              restaurantImg: each['restaurant']
                                  ['restaurantImg'],
                              restaurantName: each['restaurant']
                                  ['restaurantName'],
                              restaurantRate: each['restaurant']
                                  ['restaurantRate'],
                              restaurantId: each['restaurant']
                              ['restaurantId']);

                          restaurants.add(restaurant);
                          Users user = Users(
                              isPlay: each['isPlay'],
                              restaurant: restaurant,
                              score: each['score'],
                              userName: each['name'],
                          id:each['id'] );
                          if(user.id==_auth.currentUser.uid){
                            Provider.of<Notifier>(context, listen: true).changeIndexUser(counter);
                          }
                          users.add(user);
                          counter++;
                        }
                      }
                      print('users');
                      print(users);
                      Provider.of<Notifier>(context, listen: false)
                          .changeUsersList(users);

                      Provider.of<Notifier>(context, listen: false)
                          .changeRestaurantList(restaurants);
                      print('users');

                    } else {
                      Map map = snapshot.data.snapshot.value;

                      Provider.of<Notifier>(context, listen: false)
                          .changeChallengeName(
                              map.values.first['challengeName'].toString());
                      Provider.of<Notifier>(context, listen: false)
                          .changeIsStartPlay(map.values.first['isStartPlay']);
                      Provider.of<Notifier>(context, listen: false)
                          .changeIsEndPlay(map.values.first['isEndPlay']);
                      print('aaaa');
                      Provider.of<Notifier>(context, listen: false)
                          .changeReferral(
                              map.values.first['referralCode'].toString());
                      print('ddddddddddd');

                      if (map.values.first['users'] != null) {
                        for (Map each in map.values.first['users'].values) {
                          Restaurant restaurant = Restaurant(
                              restaurantAddress: each['restaurant']
                                  ['restaurantAddress'],
                              restaurantImg: each['restaurant']
                                  ['restaurantImg'],
                              restaurantName: each['restaurant']
                                  ['restaurantName'],
                              restaurantRate: each['restaurant']
                                  ['restaurantRate'],
                              restaurantId: each['restaurant']
                              ['restaurantId']);
                          restaurants.add(restaurant);
                          Users user = Users(
                              isPlay: each['isPlay'],
                              restaurant: restaurant,
                              score: each['score'],
                              userName: each['name'],
                              id:each['id']);
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
                    return Column(
                      children: [
                        for (int i = 0; i < users.length; i++) ...{
                          Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    users.elementAt(i).userName,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        }
                      ],
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            if ((Provider.of<Notifier>(context, listen: false).role ==
                    'user') &&
                Provider.of<Notifier>(context, listen: true).isStartPlay &&
                !Provider.of<Notifier>(context, listen: true)
                    .users
                    .elementAt(
                        Provider.of<Notifier>(context, listen: true).indexUser)
                    .isPlay)...{
              TextButton(onPressed: () {Navigator.pushNamed(context, GameScreen.id);}, child: Text('Play'))
            },
            if((Provider.of<Notifier>(context, listen: false).role ==
                'Admin') )...{
              Row(
                children: [
                  TextButton(onPressed: () {changeStatus(context,true);}, child: Text('startPlay')),
                  TextButton(onPressed: () {changeStatus(context,false);}, child: Text('endPlay'))

                ],
              )
            }
          ],
        ),
      ),
    );
  }




  changeStatus(BuildContext context,bool isStart)async{
    print('kkkk');
    try {
      DatabaseReference databaseRef=dbRef.child(Provider.of<Notifier>(context,listen: false).referral);
      // DatabaseReference databaseRef = dbRef.push();
      isStart?await databaseRef.update({
        'isStartPlay':true,
      }):await databaseRef.update({
        'isEndPlay':true,
      });
    } catch (e) {
      print(e);
    }
  }


}
