import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:restaurant_challenge_app/model/info_restaurant.dart';
import 'package:restaurant_challenge_app/model/notifier.dart';
import 'dart:convert' as convert;
import '../../constants.dart';


class ListRestaurant extends StatefulWidget {
  static String id = 'list_restaurant_screen';

  const ListRestaurant({Key key}) : super(key: key);

  @override
  _ListRestaurantState createState() => _ListRestaurantState();
}

class _ListRestaurantState extends State<ListRestaurant> {

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
          locationRestaurantWidget(Provider.of<Notifier>(context, listen: false).location),
          Expanded(
            child: FutureBuilder(
              future: http.get(
                Uri.parse('$mainUrl' + 'search?location='+'${Provider.of<Notifier>(context, listen: false).location}'),
                headers: {
                  "Authorization":
                      "Bearer Z9D7xTUxtz5u3gMnzLQ-5BjgyQF0dJVQ_jz3kYQkwqjH3DnmcvtRDycgDJ19IUKnvQF3Dy7ZNBnuNgXuTWvXkFaHFNaK8-vPGN3PcKzrIXgDKGrYyJ4gRTdl8jTFYHYx",
                },
              ),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  http.Response response = snapshot.data;
                  if (response.statusCode < 300) {
                    var jsonResponse = convert.jsonDecode(response.body);
                    var rest = jsonResponse["businesses"] as List;
                    List<Businesses> businesses = [];
                    businesses = rest
                        .map<Businesses>((json) => Businesses.fromJson(json))
                        .toList();
                    return ListView.builder(
                      itemCount: businesses.length,
                      itemBuilder: (context, index) {
                        return cardListRestaurantWidget(
                            businesses[index].imageUrl,
                            businesses[index].name,
                            businesses[index].rating.round(),
                            businesses[index].location.address1 +
                                " | " +
                                businesses[index].location.city +
                                " | " +
                                businesses[index].location.state +
                                " | " +
                                businesses[index].location.zipCode,
                            businesses[index].reviewCount,businesses[index].id);
                      },
                    );
                    // }
                  } else {
                    return Center(
                      child: Text(
                        'An Error happened',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }
                  return SizedBox();
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Container locationRestaurantWidget(String location) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFFFFFFF),
            blurRadius: 19.0,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.location_searching_rounded,
            size: 17.0,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Location:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            location,
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }

  InkWell cardListRestaurantWidget(
      String img, String name, int rate, String address, int review,String id) {
    return InkWell(
      onTap: () async{
        Provider.of<Notifier>(context, listen: false).changeIsSelected(true);
        Provider.of<Notifier>(context, listen: false).changeImg(img);
        Provider.of<Notifier>(context, listen: false).changeName(name);
        Provider.of<Notifier>(context, listen: false).changeRate(rate);
        Provider.of<Notifier>(context, listen: false).changeAddress(address);
        Provider.of<Notifier>(context, listen: false).changeRestaurantId(id);

        final DatabaseReference dbRef1 = FirebaseDatabase.instance
            .reference()
            .child('restaurant')
            .child( Provider.of<Notifier>(context, listen: false).id);
        await dbRef1.once().then(( value) {
          print(value.value['restaurantReview']);

          Provider.of<Notifier>(context, listen: false).changeRestaurantReview(value.value['restaurantReview']);
          print('true');


        });
        Navigator.pop(context);
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
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage("$img"))),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "$name",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        for (var i = 0; i < rate; i++)
                          Icon(
                            Icons.star_rate_rounded,
                            size: 20,
                            color: Colors.orange,
                          ),
                        for (var i = 5; i > rate; i--)
                          Icon(
                            Icons.star_border_rounded,
                            size: 20,
                            color: Colors.orange,
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      address,
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      height: 8,
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
                    Text('$review'),
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
