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
  final defaultFont = new TextStyle(
    fontSize: 20,
    letterSpacing: 2.0,
    color: Colors.grey[600],
  );

  final themeBg = Colors.yellow[600];
  final btnBg = Colors.blueGrey[600];

  final userValue = TextEditingController(),
      convertedValue = TextEditingController();

  String _fromvalue = "USD", _toValue = "USD";

  static const List<String> CURRENCY = ["CAD", "HKD", "ISK", "USD"];

  void fetchData() async {
    final String amount = userValue.text;
    print(amount);
    print("to where : $_toValue");
    print("from where : $_fromvalue");

    var response = await http.get(
        Uri.encodeFull(
            "https://api.exchangeratesapi.io/latest?base=$_fromvalue&symbols=$_toValue"),
        headers: {"Accept": "application/json"});

    Map<String, dynamic> data = json.decode(response.body);
    final double rates = data["rates"][_toValue];
    print("rates $rates");
    final double result = rates * double.parse(amount);
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Container(
            height: 45,
            width: 300.0,
            alignment: Alignment.center,
            child: new Row(children: <Widget>[
              DropdownButtonHideUnderline(
                  child: ButtonTheme(
                      alignedDropdown: true,
                      child: new DropdownButton(
                          isExpanded: false,
                          value: _fromvalue,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(
                              backgroundColor: themeBg, color: Colors.white),
                          onChanged: (String newValue) => {
                                setState(() => {
                                      _fromvalue = newValue,
                                    })
                              },
                          items: [
                            for (String i in CURRENCY)
                              DropdownMenuItem(
                                value: i,
                                child: Text('$i'),
                              )
                          ]))),
              Expanded(
                  child: new TextField(
                textAlign: TextAlign.center,
                controller: userValue,
                style: defaultFont,
                decoration: InputDecoration(hintText: 'The amount to convert'),
              ))
            ])),
        new Container(
            margin: const EdgeInsets.all(20),
            child: FlatButton(
              color: themeBg,
              onPressed: fetchData,
              child: new Text(
                "Convert",
                style: defaultFont,
              ),
            )),
        new Container(
            height: 45,
            width: 300.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(border: Border.all(color: btnBg)),
            child: new Row(children: <Widget>[
              DropdownButtonHideUnderline(
                  child: ButtonTheme(
                      padding: const EdgeInsets.all(20),
                      alignedDropdown: true,
                      child: new DropdownButton(
                          value: _toValue,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(
                              backgroundColor: themeBg, color: Colors.white),
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
                          ]))),
              Expanded(
                  child: new TextField(
                textAlign: TextAlign.center,
                controller: convertedValue,
                style: defaultFont,
                enabled: false,
              )),
            ]))
      ],
    );
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
