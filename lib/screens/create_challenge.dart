import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_challenge_app/model/field_notifier.dart';
import 'package:restaurant_challenge_app/model/notifier.dart';
import 'package:restaurant_challenge_app/screens/register_phone_screen.dart';

import '../static_methods.dart';
import 'challenge/manage.dart';
import 'date_picker/date_picker_widget.dart';
import 'date_picker/time_picker_widget.dart';

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Create Game'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
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
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.logout),
      //   onPressed: () async {
      //     await _auth.signOut();
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => RegisterPhoneScreen(),
      //       ),
      //     );
      //   },
      // ),
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
          Provider.of<Notifier>(context,listen: false).changeRole('Admin');
          Navigator.pushNamed(context,ChallengeManagement.id );
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
    final DatabaseReference dbRef = FirebaseDatabase.instance
        .reference()
        .child('challenges').child(id.toString());
    await dbRef.set(
        {
          'challengeName': challengeNameController.text,
          'date': Provider
              .of<FieldNotifier>(context, listen: false)
              .date
              .toString(),
          'time': '${Provider
              .of<FieldNotifier>(context, listen: false)
              .time
              .hour}:${Provider
              .of<FieldNotifier>(context, listen: false)
              .time
              .minute}',
          'isActive': true,
          'isStartPlay': false,
          'isEndPlay': false,
          'city': textEditingController.text,
          'referralCode':id ,
          'creatorId':_auth.currentUser.uid ,
          'filter':'${_auth.currentUser.uid}_true',
        }
    ).onError((error, stackTrace) {
      check=false;
    });
    return check;

    // final DatabaseReference dbRef1 = FirebaseDatabase.instance
    //     .reference()
    //     .child('challenges').child(_auth.currentUser.uid).child('-McEdv-epEg_4KlMkwIT').child('users').push();
    //
    // // dbRef1.onValue.first.then((value) => print(value.snapshot.value));
    // dbRef1.update({
    //   'name':'nn'
    // });
  }

}
