import 'package:flutter/material.dart';
import 'package:restaurant_challenge_app/model/users.dart';

class Notifier extends ChangeNotifier {
  bool isSelected = false;
  bool isStartPlay = false;
  bool isEndPlay = false;
  bool isActive = false;
  int indexUser = 0;
  String location;
  String img;
  String name = '';
  String id = '';
  int rate;
  int review = 0;
  String address;
  String role;
  String referral;
  String challengeName = '';
  List<Restaurant> restaurantList = [];
  List<Restaurant> uniqueRestaurantList = [];
  List<int> countRestaurantList = [];
  List<Users> users = [];

  Restaurant winnerRestaurant=Restaurant(restaurantName: 'Restaurant name unknown',restaurantId: '',restaurantRate: 0,restaurantImg: '',restaurantAddress: 'Restaurant address');
  int winnerRestaurantScore;
  int winnerReview;

  changeWinnerRestaurant(Restaurant winnerRestaurant) {
    this.winnerRestaurant = winnerRestaurant;
    notifyListeners();
  }

  changeIsSelected(bool isSelected) {
    this.isSelected = isSelected;
    notifyListeners();
  }

  changeRestaurantReview(int review) {
    this.review = review;
    notifyListeners();
  }

  changeWinnerRestaurantScore(int winnerRestaurantScore) {
    this.winnerRestaurantScore = winnerRestaurantScore;
    notifyListeners();
  }

  changeWinnerReview(int winnerReview) {
    this.winnerReview = winnerReview;
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

  changeIsActive(bool isActive) {
    this.isActive = isActive;
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

  changeUniqueRestaurantList(List<Restaurant> uniqueRestaurantList) {
    this.uniqueRestaurantList = uniqueRestaurantList;
    notifyListeners();
  }

  changeCountRestaurantList(List<int> countRestaurantList) {
    this.countRestaurantList = countRestaurantList;
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
