import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_challenge_app/model/notifier.dart';
import 'package:restaurant_challenge_app/model/users.dart';

class RestaurantList extends StatelessWidget {
  static String id='RestaurantList';
  @override
  Widget build(BuildContext context) {
    print(Provider.of<Notifier>(context,listen:  false).restaurantList.length);

    List<Restaurant>uniqueRestaurant=[];
    for(int i=0;i<Provider.of<Notifier>(context,listen:  false).restaurantList.length;i++){
      bool check=false;

      for(int j=0;j<uniqueRestaurant.length;j++){
        if(uniqueRestaurant.elementAt(j).restaurantId==Provider.of<Notifier>(context,listen:  false).restaurantList.elementAt(i).restaurantId){
          check=true;
          break;
        }
      }
      if(check){
        print('jfdkf');
      }
      else{
        uniqueRestaurant.add(Provider.of<Notifier>(context,listen:  false).restaurantList.elementAt(i));
      }
    }

    print(uniqueRestaurant);


    return Scaffold(
      appBar: AppBar(title: Text('RestaurantList'),centerTitle: true,),
      body: SafeArea(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: uniqueRestaurant.length,
            itemBuilder: (context, index) {
              print(uniqueRestaurant.length);
              return Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                        ),
                        elevation: 10,
                        shadowColor: Colors.orange[300],
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(15.0),
                            //   child: Text(
                            //       ' score : ${Provider.of<Notifier>(context,listen:false).users.elementAt(index).score}',
                            //       style: TextStyle(fontWeight: FontWeight.bold)),
                            // ),
                            Expanded(child: SizedBox()),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(uniqueRestaurant.elementAt(index).restaurantName,
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xffd54b00),
                      child: Text(
                        (index + 1).toString()
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
