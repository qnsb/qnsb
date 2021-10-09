import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/UserAdmin/admin_screen.dart';
import 'package:flutter_a1/Screens/UserCustomer/customer_screen.dart';
import 'package:flutter_a1/Screens/UserStaff/staff_screen.dart';
import 'package:flutter_a1/api/api_service.dart';
import 'package:flutter_a1/components/alertDialogBox.dart';
import 'package:flutter_a1/components/alertIdType.dart';
import 'package:flutter_a1/components/rounded_button.dart';
import 'package:flutter_a1/components/rounded_password_field.dart';
import 'package:flutter_a1/components/userLayout.dart';
import 'package:flutter_a1/model/resetPassword_model.dart';

class Body extends StatefulWidget {
  String id;
  String userType;

  Body({Key key, @required this.id, @required this.userType}) : super(key: key);
  @override
  _BodyState createState() => _BodyState(id: id, userType: userType);
}

class _BodyState extends State<Body> {
  String id;
  String userType;
  ResetPasswordRequestModel resetPasswordRequestModel;
  _BodyState({this.id, this.userType});

  @override
  void initState() {
    resetPasswordRequestModel = new ResetPasswordRequestModel();
  }

  bool validate() {
    if (resetPasswordRequestModel.oldPassword == null ||
        resetPasswordRequestModel.oldPassword == "") {
      showAlertDialog(context, "Error", "Fill the Old Password field");
      return false;
    }
    if (resetPasswordRequestModel.password == null ||
        resetPasswordRequestModel.password == "") {
      showAlertDialog(context, "Error", "Fill the New Password field");
      return false;
    }
    if (resetPasswordRequestModel.confirmPassword == null ||
        resetPasswordRequestModel.confirmPassword == "") {
      showAlertDialog(context, "Error", "Fill the Confirm Password field");
      return false;
    }
    if (resetPasswordRequestModel.password !=
        resetPasswordRequestModel.confirmPassword) {
      showAlertDialog(context, "Error",
          "Confirm Password does not match with new password.");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return UserLayout(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              Text(
                "Change Password",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              RoundedPasswordField(
                hintText: "Old Password",
                onChanged: (value) =>
                    {resetPasswordRequestModel.oldPassword = value},
              ),
              RoundedPasswordField(
                hintText: "New Password",
                onChanged: (value) =>
                    {resetPasswordRequestModel.password = value},
              ),
              RoundedPasswordField(
                hintText: "Confirm Password",
                onChanged: (value) =>
                    {resetPasswordRequestModel.confirmPassword = value},
              ),
              RoundedButton(
                text: "UPDATE",
                press: () {
                  if (validate()) {
                    resetPasswordRequestModel.id = id;
                    APIService apiService = new APIService();
                    apiService
                        .resetPassword(resetPasswordRequestModel)
                        .then((value) async {
                      if (value.message == "Password got reset.") {
                        showAlertDialogByIdType(context, "Password Changed",
                            value.message, id, userType);
                      } else {
                        showAlertDialog(context, "Error", value.message);
                      }
                    });
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                backgroundColor: Colors.blue),
          ],
          onTap: (i) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  if (userType == '1') {
                    return AdminScreen();
                  } else if (userType == '2') {
                    return StaffScreen();
                  } else{
                    return CustomerScreen(userID: id);         
                  }   
                },
              ),
            );
          },
        ));
  }
}
