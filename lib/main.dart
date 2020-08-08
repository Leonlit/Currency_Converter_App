import 'package:flutter/material.dart';

//the main function for starting the app
void main() => runApp(CurrencyConverter());

class CurrencyConverter extends StatelessWidget {
  final bgColor = Colors.yellow[600];

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
        home: Scaffold (
          appBar: AppBar(
            title: Text("Currency Converter"),
            titleSpacing: 1.2,
            centerTitle: true,
            backgroundColor: bgColor,
          ),
          body: Center(
            child: Homepage()
          ),
        )
    );
  }
}

class Homepage extends StatelessWidget {
  final defaultFont = new TextStyle(
      fontSize: 20,
      letterSpacing: 2.0,
      color: Colors.grey[600],
  );

  final themeBg = Colors.yellow[600];
  final btnBg = Colors.blueGrey[600];

  @override
  Widget build(BuildContext context) {
    return new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Container(
              height: 45,
              width: 300.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: btnBg)
              ),
              child : new TextField(
                  textAlign: TextAlign.center,
                  style: defaultFont,
                  decoration: InputDecoration (
                      border: InputBorder.none,
                      hintText: 'The amount to convert'
                  ),
              )
          ),
          new FlatButton (
            color: themeBg,
            onPressed: (){},
            child: new Text(
              "Convert",
              style: defaultFont,
            ),
          ),
          new Container(
              height: 45,
              width: 300.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: btnBg)
              ),
              child : new TextField(
                  textAlign: TextAlign.center,
                  style: defaultFont,
                  enabled: false,
              )
          ),
        ],
    );
  }
}
