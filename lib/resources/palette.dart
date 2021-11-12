import 'package:flutter/material.dart';

class Palette {
  static const primaryColor = Color.fromRGBO(0, 172, 234, 1);
  static const accentColor = Color.fromRGBO(255, 235, 59, 0.7);
  static const grey = Color.fromRGBO(106, 116, 108, 1);


  static const primaryColorOpacity = Color(0xFFFF7F50);

  static const homeCardUserName = TextStyle(
      color: primaryColor, fontSize: 22.0, fontWeight: FontWeight.bold);

  static const homeCardEmail = TextStyle(
      color: Colors.grey, fontSize: 16.0, fontWeight: FontWeight.w400);

  static const homeCardBio = TextStyle(
    fontStyle: FontStyle.italic,
      color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.w300);

}