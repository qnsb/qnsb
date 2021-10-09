import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/Login/login_screen.dart';
import 'package:flutter_a1/Screens/Signup/components/background.dart';
import 'package:flutter_a1/components/alertDialogBox.dart';
import 'package:flutter_a1/components/already_have_an_account_acheck.dart';
import 'package:flutter_a1/components/rounded_button.dart';
import 'package:flutter_a1/components/rounded_input_field.dart';
import 'package:flutter_a1/components/rounded_password_field.dart';
import 'package:flutter_a1/model/signup_model.dart';
import 'package:flutter_a1/api/api_service.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  SignupRequestModel signupRequestModel;
  bool isLoading = false;

  bool validate() {
    if(signupRequestModel.firstName == null ||
        signupRequestModel.firstName == "") {
      showAlertDialog(context, "Error", "Fill the first name field");
      return false;
    }
    if(signupRequestModel.lastName == null ||
        signupRequestModel.lastName == "") {
      showAlertDialog(context, "Error", "Fill the last name field");
      return false;
    }
    if(signupRequestModel.userName == null ||
        signupRequestModel.userName == "") {
      showAlertDialog(context, "Error", "Fill the username field");
      return false;
    }
    if(signupRequestModel.email == null || signupRequestModel.email == "") {
      showAlertDialog(context, "Error", "Fill the email field");
      return false;
    }
    if(signupRequestModel.password == null ||
        signupRequestModel.password == "") {
      showAlertDialog(context, "Error", "Fill the password field");
      return false;
    }
    if(signupRequestModel.confirmPassword == null ||
        signupRequestModel.confirmPassword == "") {
      showAlertDialog(context, "Error", "Fill the confirm Password field");
      return false;
    }
    if(signupRequestModel.password != signupRequestModel.confirmPassword) {
      showAlertDialog(context, "Error", "Password confirmation doesn't match");
      return false;
    }
    if(signupRequestModel.address == null ||
        signupRequestModel.address == "") {
      showAlertDialog(context, "Error", "Fill the address field");
      return false;
    }
    if(signupRequestModel.phoneNumber == null ||
        signupRequestModel.phoneNumber == "") {
      showAlertDialog(context, "Error", "Fill the phone number field");
      return false;
    }
    try{
      int.parse(signupRequestModel.phoneNumber);
    }catch(Error){
      showAlertDialog(context, "Error", "Phone number must be integer");
      return false;
    }
    if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(signupRequestModel.email)) {
      showAlertDialog(context, "Error", "Fill the valid email address");
      return false;
    }
    if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(signupRequestModel.password)) {
      showAlertDialog(context, "Error", "Password must contain at least one Uppercase, lowercase, number and special symbol.");
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    signupRequestModel = new SignupRequestModel();
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
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "First Name",
              onChanged: (value) => {signupRequestModel.firstName = value},
            ),
            RoundedInputField(
              hintText: "Last Name",
              onChanged: (value) => {signupRequestModel.lastName = value},
            ),
            RoundedInputField(
              hintText: "Username",
              onChanged: (value) => {signupRequestModel.userName = value},
            ),
            RoundedInputField(
              hintText: "Email",
              onChanged: (value) => {signupRequestModel.email = value},
            ),
            RoundedPasswordField(
              onChanged: (value) => {signupRequestModel.password = value},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text('Password must contain at least one Uppercase, lowercase, number and special symbol.', style:TextStyle(color: Colors.red)),
            ),
            RoundedPasswordField(
              hintText: "Confirm Password",
              onChanged: (value) =>
                  {signupRequestModel.confirmPassword = value},
            ),
            RoundedInputField(
              hintText: "Address",
              onChanged: (value) => {signupRequestModel.address = value},
            ),
            RoundedInputField(
              hintText: "Phone",
              onChanged: (value) => {signupRequestModel.phoneNumber = value},
            ),
            isLoading ?  Container(
            child: Center(
              child: CircularProgressIndicator(),
            )) : RoundedButton(
              text: "SIGNUP",
              press: () async {
                setState(() {
                  isLoading=true;
                });
                if(validate()) {
                  APIService apiService = new APIService();
                  apiService.signup(signupRequestModel).then((value) async {
                    if(value.message == "user created") {
                      showAlertDialog(context, "SignUp Success", value.message);
                    }else{
                      showAlertDialog(context, "Error", value.message);
                      setState(() {
                        isLoading=false;
                      });
                    }
                  });
                }else{
                  setState(() {
                    isLoading=false;
                  });
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
