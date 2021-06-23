import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_challenge_app/componnent/base_ticket_widget.dart';
import 'package:restaurant_challenge_app/constants.dart';
import 'package:restaurant_challenge_app/model/field_notifier.dart';
import 'package:restaurant_challenge_app/model/notifier.dart';
import 'package:restaurant_challenge_app/screens/auth_screen.dart';
import 'package:restaurant_challenge_app/screens/register_phone_screen.dart';

import '../../static_methods.dart';
import 'manage.dart';
import '../date_picker/date_picker_widget.dart';
import '../date_picker/time_picker_widget.dart';

class ChallengeScreen extends StatefulWidget {
  static String id = 'ChallengeScreen';

  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  final _auth = FirebaseAuth.instance;
  int _currentStep = 0;
  TextEditingController textEditingController,challengeNameController;
  StepperType stepperType = StepperType.vertical;
  Random random = Random();
  String name,date,time,referral,city;
  @override
  void initState() {
    textEditingController = TextEditingController();
    challengeNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    challengeNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Create Game'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          iconSize: 20.0,
          icon: Icon(Icons.arrow_back_ios),
          color: kColorWhite,
          onPressed: () {
            Navigator.pushNamed(context, AuthScreen.id);
          },
        ),
      ),
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Center(
          child: BaseTicketWidget(
            width: size.width / 1.15,
            height: size.height / 1.28,
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
                  Expanded(
                    child: Stepper(
                      type: stepperType,
                      physics: ScrollPhysics(),
                      currentStep: _currentStep,
                      onStepTapped: (step) => tapped(step),
                      onStepContinue: continued,
                      onStepCancel: cancel,
                      steps: <Step>[
                        Step(
                          title: Text('Game Name'),
                          content: Column(
                            children: <Widget>[

                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Game Name'),
                                controller: challengeNameController,
                                maxLines: 3,
                              ),
                            ],
                          ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 0
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: Text('Date You Want To Go To The Restaurant'),
                          content: Column(
                            children: <Widget>[
                              DatePickerWidget(),
                            ],
                          ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 1
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: Text('Time You Want To Go To The Restaurant'),
                          content: Column(
                            children: <Widget>[
                              TimePickerWidget(),
                            ],
                          ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 2
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: Text('City Name'),
                          content: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'City Name'),
                                controller: textEditingController,
                              ),
                            ],
                          ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 3
                              ? StepState.complete
                              : StepState.disabled,
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
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() async{
    if (_currentStep >= 3) {
      if(challengeNameController.text.length < 0){
        ScaffoldMessenger.of(context).showSnackBar(
          StaticMethods.mySnackBar(
              'Enter your Game Name', MediaQuery.of(context).size),
        );
        return false;
      }
      if(challengeNameController.text.length < 6){
        ScaffoldMessenger.of(context).showSnackBar(
          StaticMethods.mySnackBar(
              'The Game name must be at least 6 characters long', MediaQuery.of(context).size),
        );
        return false;
      }
      if(Provider.of<FieldNotifier>(context,listen: false).date == null){
        ScaffoldMessenger.of(context).showSnackBar(
          StaticMethods.mySnackBar(
              'Specify the date of the game', MediaQuery.of(context).size),
        );
        return false;
      }
      if(Provider.of<FieldNotifier>(context,listen: false).time == null){
        ScaffoldMessenger.of(context).showSnackBar(
          StaticMethods.mySnackBar(
              'Specify the game time', MediaQuery.of(context).size),
        );
        return false;
      }
      if(textEditingController.text.length < 2){
        ScaffoldMessenger.of(context).showSnackBar(
          StaticMethods.mySnackBar(
              'Enter the name of the city', MediaQuery.of(context).size),
        );
        return false;
      }else{
        bool check=await createChallenge();
        if(check){
          Provider.of<Notifier>(context, listen: false).changeReferral(referral);
          Provider.of<Notifier>(context, listen: false).changeIsStartPlay(false);
          Provider.of<Notifier>(context, listen: false).changeIsEndPlay(false);
          Navigator.popAndPushNamed(
            context,
            ChallengeManagement.id,
            arguments: {
              'challengeName': challengeNameController.text,
              'city': textEditingController.text,
              'time': time,
              'date': date,
            },
          );
        }
      }
    }
    else {
      _currentStep < 3
          ? setState(() => _currentStep += 1)
          : setState(() => null);
    }
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : setState(() => null);
  }

  Future<bool>createChallenge() async {
    bool check=true;
    int id=random.nextInt(9000000) + 1000000;
    date=Provider.of<FieldNotifier>(context, listen: false).date.toString();
    String hour=Provider.of<FieldNotifier>(context, listen: false).time.hour.toString();
    String minute=Provider.of<FieldNotifier>(context, listen: false).time.minute.toString();
    hour.length == 1 ? hour="0"+hour : hour=hour ;
    minute.length == 1 ? minute="0"+minute : minute=minute ;
    time="$hour:$minute";
    final DatabaseReference dbRef = FirebaseDatabase.instance
        .reference()
        .child('challenges').child(id.toString());
    await dbRef.set(
        {
          'challengeName': challengeNameController.text,
          'date': date,
          'time': time,
          'isActive': true,
          'isStartPlay': false,
          'isEndPlay': false,
          'city': textEditingController.text,
          'referralCode': id,
          'creatorId': _auth.currentUser.uid,
          'filter': '${_auth.currentUser.uid}_true',
        }
    ).onError((error, stackTrace) {
      check=false;
    });
    referral=id.toString();
    return check;
  }

}
