import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/Profile/profile_screen.dart';
import 'package:flutter_a1/Screens/Service/service_screen.dart';
import 'package:flutter_a1/Screens/UserAdmin/admin_screen.dart';
import 'package:flutter_a1/Screens/UserCustomer/customer_screen.dart';
import 'package:flutter_a1/Screens/UserStaff/staff_screen.dart';

showAlertDialogByIdType(BuildContext context, String type, String message,
    String id, String userType) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text('OK'),
    onPressed: () {
      Navigator.of(context).pop();
      if (type.toString() == "Service Booked") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ServiceScreen(id:id);
            },
          ),
        );
      }
      if (type.toString() == "Service Cancelled") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ServiceScreen(id:id);
            },
          ),
        );
      }
      if (type.toString() == "Service Cancelled Staff") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return StaffScreen();
            },
          ),
        );
      }
      if (type.toString() == "Update Success") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProfileScreen(id: id, userType: userType);
            },
          ),
        );
      }
      if (type.toString() == "Delete Success") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return AdminScreen();
            },
          ),
        );
      }
      if (type.toString() == "Service Update Success") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ServiceScreen(id: id);
            },
          ),
        );
      }
      if (type.toString() == "Password Changed") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              if (userType == '1') {
                return AdminScreen();
              } else if (userType == '2') {
                return StaffScreen();
              } 
                return CustomerScreen(userID: id);             
            },
          ),
        );
      }
      if (type.toString() == "date added") {
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ServiceScreen(
                  id: id,
            );
            },
          ),
        );
      }
      if (type.toString() == "Date Deleted.") {
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ServiceScreen(
                  id: id,
            );
            },
          ),
        );
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
