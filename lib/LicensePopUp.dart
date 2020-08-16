import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LicensePopUp {
  static List<Widget> aboutBoxChildren(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.bodyText2;

    return <Widget>[
      SizedBox(height: 24),
      RichText(
          text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              style: textStyle,
              text: 'Currency Converter is an utility app where it lets user'
                  ' perform currency conversion from one currency to another.'
                  ' This application\'s source code has been open sourced, You '
                  'can get it at \n\n'),
          TextSpan(
              style: textStyle.copyWith(color: Theme.of(context).accentColor),
              text: 'https://github.com/Leonlit/Currency_Converter_App'),
          TextSpan(style: textStyle, text: '.'),
        ],
      ))
    ];
  }
}
