import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/Signup/components/background.dart';
import 'package:flutter_a1/Screens/UserAdmin/admin_screen.dart';
import 'package:flutter_a1/components/alertDialogBox.dart';
import 'package:flutter_a1/components/rounded_button.dart';
import 'package:flutter_a1/components/rounded_input_field.dart';
import 'package:flutter_a1/components/rounded_password_field.dart';
import 'package:flutter_a1/components/text_field_container.dart';
import 'package:flutter_a1/components/userLayout.dart';
import 'package:flutter_a1/model/createUser_model.dart';
import 'package:flutter_a1/api/api_service.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CreateUserRequestModel createUserRequestModel;
  List<ListItem> _dropdownItems = [
    ListItem(2, "Staff"),
    ListItem(0, "Customer")
  ];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  @override
  void initState() {
    super.initState();
    createUserRequestModel = new CreateUserRequestModel();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[1].value;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  bool validate() {
    if (createUserRequestModel.firstName == null ||
        createUserRequestModel.firstName == "") {
      showAlertDialog(context, "Error", "Fill the first name field");
      return false;
    }
    if (createUserRequestModel.lastName == null ||
        createUserRequestModel.lastName == "") {
      showAlertDialog(context, "Error", "Fill the last name field");
      return false;
    }
    if (createUserRequestModel.userName == null ||
        createUserRequestModel.userName == "") {
      showAlertDialog(context, "Error", "Fill the username field");
      return false;
    }
    if (createUserRequestModel.email == null ||
        createUserRequestModel.email == "") {
      showAlertDialog(context, "Error", "Fill the email field");
      return false;
    }
    if (createUserRequestModel.password == null ||
        createUserRequestModel.password == "") {
      showAlertDialog(context, "Error", "Fill the password field");
      return false;
    }
    if (createUserRequestModel.confirmPassword == null ||
        createUserRequestModel.confirmPassword == "") {
      showAlertDialog(context, "Error", "Fill the confirm Password field");
      return false;
    }
    if (createUserRequestModel.password !=
        createUserRequestModel.confirmPassword) {
      showAlertDialog(context, "Error", "Password confirmation doesn't match");
      return false;
    }
    if (createUserRequestModel.address == null ||
        createUserRequestModel.address == "") {
      showAlertDialog(context, "Error", "Fill the address field");
      return false;
    }
    if (createUserRequestModel.phoneNumber == null ||
        createUserRequestModel.phoneNumber == "") {
      showAlertDialog(context, "Error", "Fill the phone number field");
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
              "Create User",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "First Name",
              onChanged: (value) => {createUserRequestModel.firstName = value},
            ),
            RoundedInputField(
              hintText: "Last Name",
              onChanged: (value) => {createUserRequestModel.lastName = value},
            ),
            RoundedInputField(
              hintText: "Username",
              onChanged: (value) => {createUserRequestModel.userName = value},
            ),
            RoundedInputField(
              hintText: "Email",
              onChanged: (value) => {createUserRequestModel.email = value},
            ),
            RoundedPasswordField(
              onChanged: (value) => {createUserRequestModel.password = value},
            ),
            RoundedPasswordField(
              hintText: "Confirm Password",
              onChanged: (value) =>
                  {createUserRequestModel.confirmPassword = value},
            ),
            RoundedInputField(
              hintText: "Address",
              onChanged: (value) => {createUserRequestModel.address = value},
            ),
            RoundedInputField(
              hintText: "Phone",
              onChanged: (value) =>
                  {createUserRequestModel.phoneNumber = value},
            ),
            TextFieldContainer(
              child: Row(
                children: <Widget>[
                  Text('User Type'),
                  SizedBox(width: size.width * 0.03),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        border: Border.all()),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          value: _selectedItem,
                          items: _dropdownMenuItems,
                          onChanged: (value) {
                            setState(() {
                              _selectedItem = value;
                            });
                          }),
                    ),
                  ),
                ],
              ),
            ),
            RoundedButton(
              text: "CREATE",
              press: () async {
                if (validate()) {
                  createUserRequestModel.userType =
                      _selectedItem.value.toString();
                  APIService apiService = new APIService();
                  apiService
                      .createUser(createUserRequestModel)
                      .then((value) async {
                    if (value.message == "user created") {
                      showAlertDialog(context, "Create Success", value.message);
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
              icon: Icon(Icons.arrow_back),
              title: Text('Back'),
              backgroundColor: Colors.blue),
        ],
        onTap: (i) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AdminScreen();
              },
            ),
          );
        },
      ),
    );
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
