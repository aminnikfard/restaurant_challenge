import 'package:flutter/material.dart';
import 'package:restaurant_challenge_app/screens/register_phone_screen.dart';


class RegisterEmailScreen extends StatefulWidget {
  static String id = 'register_email_screen';

  @override
  _RegisterEmailScreenState createState() => _RegisterEmailScreenState();
}

class _RegisterEmailScreenState extends State<RegisterEmailScreen> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Restaurant App",
      theme: ThemeData(primaryColor: Theme.of(context).primaryColor),
      home: Scaffold(
        backgroundColor: Color(0xFFF6F5FA),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      iconSize: 20.0,
                      padding: EdgeInsets.only(top: 60),
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Image(
                      width: 310.0,
                      image: AssetImage("assets/images/shape.png"),
                    )
                  ],
                ),
              ),
              Container(
                height: 40.0,
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      top: -120,
                      child: Image(
                        image: AssetImage("assets/images/logo.png"),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.grey[200],
                          blurRadius: 2.0,
                          offset: Offset(0, 5.0))
                    ]),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Register Account Using Email Address",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: <Widget>[
                              TextField(
                                decoration: InputDecoration(
                                    labelText: "Email*",
                                    labelStyle: TextStyle(fontSize: 14.0),
                                    suffixIcon: Icon(
                                      Icons.mail,
                                      size: 17.0,
                                    )),
                              ),
                              TextField(
                                obscureText: _hidePassword,
                                decoration: InputDecoration(
                                    labelText: "Password*",
                                    labelStyle: TextStyle(fontSize: 14.0),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _hidePassword = !_hidePassword;
                                        });
                                      },
                                      icon: Icon(
                                        _hidePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        size: 17.0,
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Theme.of(context).primaryColor,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[200],
                                    blurRadius: 2.0,
                                    offset: Offset(0, 4.0))
                              ]),
                          margin: EdgeInsets.only(top: 20.0),
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          width: 200.0,
                          child: Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 12.0),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Or Register using",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(width: 5.0),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterPhoneScreen()));
                                    },
                                    child: Text(
                                      "Phone Number",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already have an account?",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 5.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute());
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
