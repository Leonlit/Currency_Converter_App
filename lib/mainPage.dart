import 'package:currency_converter/popUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import 'dart:io';
import "dart:async";
import "dart:convert";

import 'utilities.dart';
import 'popUp.dart';

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

  MoneyFormatterOutput formatNumbers(double value) {
    MoneyFormatterOutput display = FlutterMoneyFormatter(
            amount: value,
            settings: MoneyFormatterSettings(
                symbol: _toValue,
                thousandSeparator: '.',
                decimalSeparator: ',',
                symbolAndNumberSeparator: ' ',
                fractionDigits: 4,
                compactFormatType: CompactFormatType.short))
        .output;
    return display;
  }

  BuildContext currContext;

  Future<void> fetchData() async {
    if (userValue.text == "") {
      ShowErrorPopUp.showError(currContext, "Empty Value!",
          "The value that you've provided is empty. Please provide a number berfore converting it to another currency.");
    }
    try {
      double result = await RequestAPIData.fetchData(
          userValue.text, _toValue, _fromValue, currContext);

      convertedValue.text =
          convertedValue.text = formatNumbers(result).compactNonSymbol;
    } on FormatException {
      ShowErrorPopUp.showError(currContext, "Invalid number!",
          "Sorry but the value that you've provided are not in number form.");
    }
  }

  @override
  Widget build(BuildContext context) {
    currContext = context;
    return new Container(
        margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Container(
                alignment: Alignment.center,
                child: new Row(children: [
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
  static Future<double> fetchData(String userValue, String toValue,
      String fromValue, BuildContext currContext) async {
    File file;
    String response;

    try {
      file = await DefaultCacheManager()
          .getSingleFile(
              "https://api.exchangeratesapi.io/latest?base=$fromValue&symbols=$toValue")
          .timeout(const Duration(seconds: 5));
      response = await file.readAsString();
    } on SocketException {
      ShowErrorPopUp.showError(currContext, "Connection Error!!!",
          "No Connection To The Server. Please make sure you're connected to the internet or try again later.");
    } on TimeoutException {
      ShowErrorPopUp.showError(currContext, "Internet Connection Error!!!",
          "There's something wrong with your internet connection. Please try again later.");
    }
    Map<String, dynamic> data = json.decode(response);
    final double rates = data["rates"][toValue];
    final double result = rates * double.parse(userValue);
    return result;
  }
}
