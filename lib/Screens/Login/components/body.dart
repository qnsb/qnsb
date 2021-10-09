import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/Login/components/background.dart';
import 'package:flutter_a1/Screens/Signup/signup_screen.dart';
import 'package:flutter_a1/Screens/UserAdmin/admin_screen.dart';
import 'package:flutter_a1/Screens/UserStaff/staff_screen.dart';
import 'package:flutter_a1/Screens/UserCustomer/customer_screen.dart';
import 'package:flutter_a1/components/already_have_an_account_acheck.dart';
import 'package:flutter_a1/components/rounded_button.dart';
import 'package:flutter_a1/components/rounded_input_field.dart';
import 'package:flutter_a1/components/rounded_password_field.dart';
import 'package:flutter_a1/api/api_service.dart';
import 'package:flutter_a1/model/login_model.dart';
import 'package:flutter_a1/components/alertDialogBox.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  LoginRequestModel loginRequestModel;
  bool loading;
  String token;

  @override
  void initState() {
    super.initState();
    loading = false;
    loginRequestModel = new LoginRequestModel();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            Image(image: AssetImage('assets/icons/logo.png')),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Username",
              onChanged: (value) => {loginRequestModel.userName = value.trim()},
            ),
            RoundedPasswordField(
              onChanged: (value) => {loginRequestModel.password = value},
            ),
            loading
                ? Center(child: CircularProgressIndicator())
                : RoundedButton(
                    text: "LOGIN",
                    press: () {
                      if (loginRequestModel.userName != null &&
                          loginRequestModel.password != null) {
                        setState(() {
                          loading = true;
                        });
                        APIService apiService = new APIService();
                        apiService.login(loginRequestModel).then((value) async {
                          if (value.id != "") {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs?.setString("id", value.id.toString());
                            prefs?.setString(
                                "userType", value.userType.toString());

                            if (value.userType.toString() == "1") {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AdminScreen();
                                  },
                                ),
                              );
                            }
                            if (value.userType.toString() == "2") {
                              await FirebaseMessaging.instance
                                  .subscribeToTopic('Staff').catchError((e){print('error unsubscribing.');});

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return StaffScreen();
                                  },
                                ),
                              );
                            }
                            if (value.userType.toString() == "0") {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CustomerScreen(userID:value.id.toString());
                                  },
                                ),
                              );
                            }
                          } else {
                            if (value.message != "") {
                              showAlertDialog(context, "Error", value.message);
                              setState(() {
                                loading = false;
                              });
                            }
                          }
                        });
                      }
                    },
                  ),
            SizedBox(height: size.height * 0.03),

            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  
  getToken() async{
    token = await FirebaseMessaging.instance.getToken();
    setState(() {
      token=token;
    });
  }
}
