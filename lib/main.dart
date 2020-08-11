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

class Homepage extends StatefulWidget{
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

  void fetchData() async{
    var response = await http.get(
      Uri.encodeFull("https://api.exchangeratesapi.io/latest?base=USD&symbols=MYR"),
      headers: {
        "Accept" : "application/json"
      }
    );

    Map<String, dynamic> data = json.decode(response.body);
    print(data["rates"]["MYR"]);
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
          onPressed: fetchData,
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

Future<String> readFile () async {
  try {
    final file = await _localFile;
    String contents = await file.readAsString();
    return contents;
  }catch (err) {
    print (err);
  }
  return "";
}