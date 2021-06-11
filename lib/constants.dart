import 'package:flutter/material.dart';

final kOutLineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
);

final kTopOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(10),
    topLeft: Radius.circular(10),
  ),
);

final kHeaderTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.black,
);

final kCustomAppBarDecoration = BoxDecoration(
  color: Colors.blueAccent,
  borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30)
  ),
);

final kCustomProgressIndicator = Container(
  height: 80,
  width: 80,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.blueGrey,
  ),
  child: Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    ),
  ),
);