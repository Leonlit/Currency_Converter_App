import 'package:currency_converter/aboutPage.dart';
import 'package:flutter/material.dart';

import 'mainPage.dart';
import 'aboutPage.dart';

//the main function for starting the app
void main() => runApp(CurrencyConverter());

class CurrencyConverter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => new Homepage(),
        "/aboutPage": (context) => new AboutPage(),
      },
    );
  }

  static final Map<String, dynamic> route = {
    "/": new Homepage(),
    "/aboutPage": new AboutPage()
  };

  static String _currentPage = "/";
  static void goToPage(BuildContext context, String pageName) {
    if (_currentPage != pageName) {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => route[pageName]));
    } else
      Navigator.pop(context);

    _currentPage = pageName;
  }
}
