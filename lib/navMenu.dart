import 'package:currency_converter/aboutPage.dart';
import 'package:currency_converter/popUp.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'utilities.dart';
import 'main.dart';
import 'aboutPage.dart';
import 'popUp.dart';

class NavMenu extends StatelessWidget {
  BuildContext currContext;
  @override
  Widget build(BuildContext context) {
    currContext = context;
    return ListView(
      children: <Widget>[
        DrawerHeader(
          child: new Container(
              child: Text(
                'Currency Converter',
                style: AppTheme.menuHeaderFont,
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
                  ListTile(
                    title: Text(
                      'Source Code',
                      style: AppTheme.menuFont,
                    ),
                    onTap: lauchURL,
                  )
                ]).toList()),
      ],
    );
  }

  void lauchURL() async {
    const url = 'https://github.com/Leonlit/Currency_Converter_App';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ShowErrorPopUp.showError(
          currContext, "Unable to open link!", 'Could not launch $url');
    }
  }
}
