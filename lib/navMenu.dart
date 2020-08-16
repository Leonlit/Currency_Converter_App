import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'utilities.dart';
import 'main.dart';
import 'aboutPage.dart';
import 'popUp.dart';
import 'LicensePopUp.dart';

class NavMenu extends StatefulWidget {
  @override
  _NavMenuState createState() => _NavMenuState();
}

class _NavMenuState extends State<NavMenu> {
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
                  ),
                  ListTile(
                    title: Text(
                      'License',
                      style: AppTheme.menuFont,
                    ),
                    onTap: () {
                      showAboutDialog(
                        applicationIcon: FlutterLogo(),
                        applicationName: 'Currency Converter',
                        applicationVersion: 'July 2020',
                        applicationLegalese: '© 2020 Leonlit',
                        children: LicensePopUp.aboutBoxChildren(context),
                        context: context,
                      );
                    },
                  ),
                ]).toList()),
      ],
    );
  }

  void lauchURL() async {
    final url = 'https://github.com/Leonlit/Currency_Converter_App';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ShowErrorPopUp.showError(
          currContext, "Unable to open link!", 'Could not launch $url');
    }
  }
}
