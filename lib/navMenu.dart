import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'utilities.dart';
import 'popUp.dart';
import 'LicensePopUp.dart';
import 'main.dart';

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
                      CurrencyConverter.goToPage(context, "/");
                    },
                  ),
                  ListTile(
                    title: Text(
                      'About',
                      style: AppTheme.menuFont,
                    ),
                    onTap: () {
                      CurrencyConverter.goToPage(context, "/aboutPage");
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Licenses',
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
                  ListTile(
                    title: Text(
                      'Source Code',
                      style: AppTheme.menuFont,
                    ),
                    onTap: lauchURL,
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
