import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkable/linkable.dart';

import 'navMenu.dart';
import 'utilities.dart';


class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      drawer: Drawer(
        child: NavMenu(),
      ),
      appBar: AppBar(
        title: Text(""),
        titleSpacing: 1.2,
        centerTitle: true,
        backgroundColor: AppTheme.themeBg,
      ),
      body: Center(child: AboutPageWidget()),
    ));
  }
}

class AboutPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new ListView(children: <Widget>[
        new Container(
            margin: EdgeInsets.only(bottom: 40.0, top: 20.0),
            child: new Text(
              "About The App",
              textAlign: TextAlign.center,
              style: AppTheme.pageHeaderFont,
            )),
        new Container(
            margin: EdgeInsets.all(10.0),
            child: Linkable(
              text:
                  "This app is created so that user could convert an amount of money from a currency to another currency with ease. If you're interested in the source code, you could find the link in the navigation menu or simple press this link\n\nhttps://github.com/Leonlit/Currency_Converter_App\n\nFeel free to contact me if you have any suggestions, questions, or critics \n\nemail: \nleonlit123@gmail.com\n\nreddit: \nhttps://www.reddit.com/user/scrolion\n\ntwitter: \nhttps://twitter.com/leonlit",
              textAlign: TextAlign.left,
              style: AppTheme.pageFont,
            )),
      ]),
    );
  }
}
