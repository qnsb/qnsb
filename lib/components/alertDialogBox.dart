import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/Login/login_screen.dart';
import 'package:flutter_a1/Screens/UserAdmin/admin_screen.dart';

showAlertDialog(BuildContext context, String type, String message) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text('OK'),
    onPressed: () {
      Navigator.of(context).pop();
      if (type.toString() == "SignUp Success") {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LoginScreen();
        }));
      }
      if (type.toString() == "Create Success") {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AdminScreen();
        }));
      }
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(type),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
