import "dart:async";
import "dart:convert";

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

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

class Homepage extends StatefulWidget {
  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<Homepage> {
  final fieldFont = new TextStyle(
    fontSize: 20,
    letterSpacing: 2.0,
    color: Colors.grey[600],
  );

  final btnFont = new TextStyle(
    fontSize: 20.0,
    letterSpacing: 2.0,
    color: Colors.yellow[600],
    fontWeight: FontWeight.bold,
  );

  final themeBg = Colors.yellow[600];
  final btnBg = Colors.blueGrey[600];

  final userValue = TextEditingController(),
      convertedValue = TextEditingController();

  String _fromValue = "USD", _toValue = "USD";

  static const List<String> CURRENCY = ["CAD", "HKD", "ISK", "USD"];

  void fetchData() async {
    final String amount = userValue.text;

    var response = await http.get(
        Uri.encodeFull(
            "https://api.exchangeratesapi.io/latest?base=$_fromValue&symbols=$_toValue"),
        headers: {"Accept": "application/json"});

    Map<String, dynamic> data = json.decode(response.body);
    final double rates = data["rates"][_toValue];
    final double result = rates * double.parse(amount);
    convertedValue.text = result.toStringAsFixed(3);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Container(
                alignment: Alignment.center,
                child: new Row(children: <Widget>[
                  new Container(
                      margin: EdgeInsets.fromLTRB(2.0, 0, 16.0, 0),
                      child: new DropdownButton(
                          autofocus: true,
                          focusColor: Colors.grey[300],
                          value: _fromValue,
                          style: btnFont,
                          onChanged: (String newValue) => {
                                setState(() => {
                                      _fromValue = newValue,
                                    })
                              },
                          items: [
                            for (String i in CURRENCY)
                              DropdownMenuItem(
                                value: i,
                                child: Text('$i'),
                              )
                          ])),
                  Expanded(
                      child: new TextField(
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    controller: userValue,
                    style: fieldFont,
                    decoration: InputDecoration(
                      hintText: 'Amount Value',
                    ),
                  ))
                ])),
            new Container(
                margin: const EdgeInsets.all(20),
                child: FlatButton(
                  color: themeBg,
                  onPressed: fetchData,
                  child: new Text(
                    "Convert",
                    style: fieldFont,
                  ),
                )),
            new Container(
                alignment: Alignment.center,
                child: new Row(children: <Widget>[
                  new Container(
                      margin: EdgeInsets.fromLTRB(2.0, 0, 16.0, 0),
                      child: new DropdownButton(
                          value: _toValue,
                          style: btnFont,
                          onChanged: (String newValue) => {
                                setState(() => {
                                      _toValue = newValue,
                                    })
                              },
                          items: [
                            for (String i in CURRENCY)
                              DropdownMenuItem(
                                value: i,
                                child: Text('$i'),
                              )
                          ])),
                  Expanded(
                      child: new TextField(
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    controller: convertedValue,
                    style: fieldFont,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: "Converted Value",
                    ),
                  )),
                ]))
          ],
        ));
  }
}

//check for data in storage cache
//if the api data last fetch time is before today's 14:15
//if the last fetch time < 14:15 use back cached data (file maybe)
//if not fetch the data then store into the file

Future<String> get _localPath async {
  Directory folder = await getApplicationDocumentsDirectory();
  return folder.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File("$path/asset/secret.txt");
}

Future<String> readFile() async {
  try {
    final file = await _localFile;
    String contents = await file.readAsString();
    return contents;
  } catch (err) {
    print(err);
  }
  return "";
}
