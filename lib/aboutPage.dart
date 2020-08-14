import 'package:currency_converter/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navMenu.dart';

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
          child: new Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            textAlign: TextAlign.justify,
            style: AppTheme.pageFont,
          ),
        ),
      ]),
    );
  }
}
