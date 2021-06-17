import 'package:flutter/material.dart';

class Notifier extends ChangeNotifier{
  bool isSelected=false;
  String location;
  String img;
  String name;
  int rate;
  String address;


  changeIsSelected(bool isSelected) {
    this.isSelected = isSelected;
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