import 'package:flutter/material.dart';
import 'package:restaurant_challenge_app/model/users.dart';

class Notifier extends ChangeNotifier {
  bool isSelected = false;
  bool isStartPlay = false;
  bool isEndPlay = false;
  int indexUser=0;
  String location;
  String img;
  String name='';
  String id='';
  int rate;
  String address;
  String role;
  String referral;
  String challengeName='';
  List<Restaurant> restaurantList=[];
  List<Users> users=[];


  changeIsSelected(bool isSelected) {
    this.isSelected = isSelected;
    notifyListeners();
  }
  changeIndexUser(int indexUser) {
    this.indexUser = indexUser;
    notifyListeners();
  }
  changeIsStartPlay(bool isStartPlay) {
    this.isStartPlay = isStartPlay;
    notifyListeners();
  }
  changeIsEndPlay(bool isEndPlay) {
    this.isEndPlay = isEndPlay;
    notifyListeners();
  }

  changeRestaurantList(List<Restaurant> restaurantList) {
    this.restaurantList = restaurantList;
    notifyListeners();
  }
  changeUsersList(List<Users> users) {
    this.users = users;
    notifyListeners();
  }
  changeReferral(String referral) {
    this.referral = referral;
    notifyListeners();
  }
  changeRestaurantId(String restaurantId) {
    this.id = restaurantId;
    notifyListeners();
  }
  changeChallengeName(String challengeName) {
    this.challengeName = challengeName;
    notifyListeners();
  }

  changeRole(String role) {
    this.role = role;
    notifyListeners();
  }

  changeLocation(String location) {
    this.location = location;
    notifyListeners();
  }

  changeImg(String img) {
    this.img = img;
    notifyListeners();
  }

  changeName(String name) {
    this.name = name;
    notifyListeners();
  }

  changeRate(int rate) {
    this.rate = rate;
    notifyListeners();
  }

  changeAddress(String address) {
    this.address = address;
    notifyListeners();
  }
}
