import 'package:currency_converter/aboutPage.dart';
import 'package:flutter/material.dart';

import 'utilities.dart';
import 'main.dart';
import 'aboutPage.dart';

class NavMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
          child: new Container(
              child: Text(
                'Currency Converter',
                style: AppTheme.headerFont,
              ),
              alignment: Alignment.bottomLeft),
          decoration: BoxDecoration(
            color: AppTheme.themeBg,
          ),
        ),
        new ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: ListTile.divideTiles(
                context: context,
                color: Colors.grey,
                tiles: [
                  ListTile(
                    title: Text(
                      'Home',
                      style: AppTheme.menuFont,
                    ),
                    onTap: () {
                      print("clicked item 1");
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new CurrencyConverter()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      'About',
                      style: AppTheme.menuFont,
                    ),
                    onTap: () {
                      print("clicked item 2");
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new AboutPage()),
                      );
                    },
                  ),
                ]).toList()),
      ],
    );
  }
}
