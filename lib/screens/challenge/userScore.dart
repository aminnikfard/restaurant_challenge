import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_challenge_app/model/notifier.dart';

class UserScore extends StatelessWidget {
  static String id='UserScore';
  @override
  Widget build(BuildContext context) {
    print(Provider.of<Notifier>(context,listen:  false).users.length);

    return Scaffold(
      appBar: AppBar(title: Text('ScoreUser'),centerTitle: true,),
      body: SafeArea(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: Provider.of<Notifier>(context,listen:  false).users.length,
            itemBuilder: (context, index) {
              print(Provider.of<Notifier>(context,listen:  false).users.length);
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
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                  ' score : ${Provider.of<Notifier>(context,listen:false).users.elementAt(index).score}',
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Expanded(child: SizedBox()),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(Provider.of<Notifier>(context,listen:false).users.elementAt(index).userName,
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
