import 'package:flutter/material.dart';

import 'mainPage.dart';
import 'navMenu.dart';

//the main function for starting the app
void main() => runApp(CurrencyConverter());

class CurrencyConverter extends StatelessWidget {
  final bgColor = Colors.yellow[600];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      drawer: Drawer(
        child: NavMenu(),
      ),
      appBar: AppBar(
        title: Text("Currency Converter"),
        titleSpacing: 1.2,
        centerTitle: true,
        backgroundColor: bgColor,
      ),
      body: Center(child: Homepage()),
    ));
  }
}
