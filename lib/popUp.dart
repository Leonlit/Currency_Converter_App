import 'package:flutter/material.dart';

class ShowErrorPopUp {
  static void showError(BuildContext context, String title, String message) {
    Widget okBtn = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okBtn,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
