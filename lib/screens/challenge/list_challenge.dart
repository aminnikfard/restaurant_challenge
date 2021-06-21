import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_challenge_app/constants.dart';
import 'package:restaurant_challenge_app/model/notifier.dart';
import 'package:restaurant_challenge_app/screens/challenge/create_challenge.dart';
import 'package:restaurant_challenge_app/screens/challenge/manage.dart';

class ListChallenge extends StatefulWidget {
  const ListChallenge({Key key}) : super(key: key);

  @override
  _ListChallengeState createState() => _ListChallengeState();
}

class _ListChallengeState extends State<ListChallenge> {
  DatabaseReference dbRef =
  FirebaseDatabase.instance.reference().child('challenges');
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<Map<dynamic, dynamic>> getDataAdminGame() async {
    return await dbRef
        .orderByChild('filter')
        .startAt('${auth.currentUser.uid}_true')
        .endAt('${auth.currentUser.uid}_true\uf8ff')
        .once()
        .then((data) {
      return data.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFFF5715),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChallengeScreen()));
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 25.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 5,
                          color: Colors.white,
                          blurRadius: 20.0,
                          offset: Offset(0, 0))
                    ]),
                child: Center(
                  child: Text(
                    "Create Challenge",
                    style: TextStyle(fontWeight: FontWeight.bold,color: kColorWhite),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getDataAdminGame(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  Map data = snapshot.data;
                  if (data.length > 0) {
                    List challengeItems = [];
                    data.forEach((key, value) {
                      challengeItems.add(value);
                    });
                    return ListView.builder(
                      itemCount: challengeItems.length,
                      itemBuilder: (context, index) {
                        return cardListRestaurantWidget(
                          challengeItems[index]['challengeName'],
                          challengeItems[index]['city'],
                          challengeItems[index]['date'],
                          challengeItems[index]['time'],
                          challengeItems[index]['isActive'],
                          challengeItems[index]['referralCode'],
                        );
                      },
                    );
                  }else{
                    return Center(child: Text('No challenge found for you',style: TextStyle(color: kColorWhite,fontSize: 18),),);
                  }
                } else {
                  return Center(child: CircularProgressIndicator(),);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  InkWell cardListRestaurantWidget(
      String name, String city, String date, String time, bool active,int id) {
    return InkWell(
      onTap: () {
        Provider.of<Notifier>(context, listen: false).changeReferral(id.toString());
        Navigator.popAndPushNamed(
          context,
          ChallengeManagement.id,
          arguments: {
            'challengeName': name,
            'city': city,
            'time': time,
            'date': date,
          },
        );
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => ChallengeManagement()));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFFFF5715), width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "$name",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'City',
                              style: TextStyle(fontSize: 13),
                            ),
                            Text(
                              city,
                              style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(width: 7,),
                        Column(
                          children: [
                            Text(
                              'Date',
                              style: TextStyle(fontSize: 13),
                            ),
                            Text(
                              date.substring(0, 10),
                              style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(width: 7,),
                        Column(
                          children: [
                            Text(
                              'Time',
                              style: TextStyle(fontSize: 13),
                            ),
                            Text(
                              time,
                              style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
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
                    active == true ? Icon(Icons.timelapse_rounded) : Icon(Icons.check_circle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
