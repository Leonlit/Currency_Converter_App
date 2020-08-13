import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:number_display/number_display.dart';
import "dart:async";
import "dart:convert";

import 'utilities.dart';

class Homepage extends StatefulWidget {
  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<Homepage> {
  final userValue = TextEditingController(),
      convertedValue = TextEditingController();

  String _fromValue = "USD", _toValue = "USD";
  static final List<String> currency = [
    "CAD",
    "HKD",
    "ISK",
    "PHP",
    "DKK",
    "HUF",
    "CZK",
    "AUD",
    "RON",
    "SEK",
    "IDR",
    "INR",
    "BRL",
    "RUB",
    "HRK",
    "JPY",
    "THB",
    "CHF",
    "SGD",
    "PLN",
    "BGN",
    "TRY",
    "CNY",
    "NOK",
    "NZD",
    "ZAR",
    "USD",
    "MXN",
    "ILS",
    "GBP",
    "KRW",
    "MYR"
  ];

  @override
  // ignore: must_call_super
  void initState() {
    currency.sort();
  }

  Future<void> fetchData() async {
    String result =
        await RequestAPIData.fetchData(userValue.text, _toValue, _fromValue);
    convertedValue.text = result;
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
                          style: AppTheme.btnFont,
                          onChanged: (String newValue) => {
                                setState(() => {
                                      _fromValue = newValue,
                                    })
                              },
                          items: [
                            for (String i in currency)
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
                    style: AppTheme.fieldFont,
                    decoration: InputDecoration(
                      hintText: 'Amount Value',
                    ),
                  ))
                ])),
            new Container(
                margin: const EdgeInsets.all(20),
                child: FlatButton(
                  color: AppTheme.themeBg,
                  onPressed: fetchData,
                  child: new Text(
                    "Convert",
                    style: AppTheme.fieldFont,
                  ),
                )),
            new Container(
                alignment: Alignment.center,
                child: new Row(children: <Widget>[
                  new Container(
                      margin: EdgeInsets.fromLTRB(2.0, 0, 16.0, 0),
                      child: new DropdownButton(
                          value: _toValue,
                          style: AppTheme.btnFont,
                          onChanged: (String newValue) => {
                                setState(() => {
                                      _toValue = newValue,
                                    })
                              },
                          items: [
                            for (String i in currency)
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
                    style: AppTheme.fieldFont,
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

class RequestAPIData {
  static Future<String> fetchData(
      String userValue, String toValue, String fromValue) async {
    final display = createDisplay(length: 8);
    File file;
    String response;
    try {
      file = await DefaultCacheManager().getSingleFile(
          "https://api.exchangeratesapi.io/latest?base=$fromValue&symbols=$toValue");
      response = await file.readAsString();
      print(response);
    } on SocketException {
      print("No Connection To The Server");
    } on FormatException {
      print("error occured");
    }
    Map<String, dynamic> data = json.decode(response);
    final double rates = data["rates"][toValue];
    final double result = rates * double.parse(userValue);
    return display(result);
  }
}
