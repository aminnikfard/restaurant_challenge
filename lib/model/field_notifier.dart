import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FieldNotifier extends ChangeNotifier {
  DateTime date;
  changeDate(DateTime date) {
    this.date = date;
    notifyListeners();
  }

  TimeOfDay time;
  changeTime(TimeOfDay time) {
    this.time = time;
    notifyListeners();
  }

}
