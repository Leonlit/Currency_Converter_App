import 'package:flutter/material.dart';
import 'mainWidget.dart';

//the main function for starting the app
void main() => runApp(CurrencyConverter());

class CurrencyConverter extends StatelessWidget {
  final bgColor = Colors.yellow[600];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
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


//check for data in storage cache
//if the api data last fetch time is before today's 14:15
//if the last fetch time < 14:15 use back cached data (file maybe)
//if not fetch the data then store into the file
