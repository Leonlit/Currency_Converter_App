import 'package:currency_converter/utilities.dart';
import 'package:flutter/material.dart';

import 'mainPage.dart';
import 'navMenu.dart';

//the main function for starting the app
void main() => runApp(CurrencyConverter());

class CurrencyConverter extends StatelessWidget {
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
        backgroundColor: AppTheme.themeBg,
      ),
      body: Center(child: Homepage()),
    ));
  }
}
