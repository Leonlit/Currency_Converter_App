import 'package:flutter/material.dart';

//class for storing styles for different components
class AppTheme {
  //Text field font style
  static final fieldFont = new TextStyle(
    fontSize: 20,
    letterSpacing: 2.0,
    color: Colors.grey[600],
  );

  //The style for menu items font
  static final menuFont = new TextStyle(
    fontSize: 20,
    letterSpacing: 2.0,
    fontWeight: FontWeight.w700,
    fontFamily: "Merriweather",
  );

  //the text style for menu headers
  static final menuHeaderFont = new TextStyle(
    fontSize: 26,
    letterSpacing: 2.0,
    fontWeight: FontWeight.w900,
    fontFamily: "Merriweather",
    color: Colors.white,
  );

  //the text style for page header
  static final pageHeaderFont = new TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.italic,
    letterSpacing: 2.0,
    fontFamily: "Merriweather",
  );

  //the text style for page font
  static final pageFont = new TextStyle(
    fontSize: 17,
    letterSpacing: 2.0,
    fontFamily: "Merriweather",
    fontWeight: FontWeight.w400,
  );

  //text style for buttons font
  static final btnFont = new TextStyle(
    fontSize: 20.0,
    letterSpacing: 2.0,
    color: Colors.yellow[600],
    fontWeight: FontWeight.bold,
  );

  //theme color for the app
  static final themeBg = Colors.yellow[600];
}
