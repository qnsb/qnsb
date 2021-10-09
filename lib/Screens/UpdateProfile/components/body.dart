import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/Profile/profile_screen.dart';
import 'package:flutter_a1/api/api_service.dart';
import 'package:flutter_a1/components/alertDialogBox.dart';
import 'package:flutter_a1/components/alertIdType.dart';
import 'package:flutter_a1/components/rounded_button.dart';
import 'package:flutter_a1/components/rounded_input_field_update.dart';
import 'package:flutter_a1/components/text_field_container.dart';
import 'package:flutter_a1/components/userLayout.dart';
import 'package:flutter_a1/constants.dart';
import 'package:flutter_a1/model/readProfile_model.dart';
import 'package:flutter_a1/model/updateProfile_model.dart';

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
  int count;
  ReadProfileRequestModel _readProfile;
  Future<ReadProfileResponseModel> _profile;
  UpdateProfileRequestModel updateProfileRequestModel;
  _BodyState({this.id, this.userType});
  List<ListItem> _dropdownItems = [
    ListItem(2, "Staff"),
    ListItem(0, "Customer")
  ];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  @override
  void initState() {
    _readProfile = new ReadProfileRequestModel();
    _readProfile.id = id;
    APIService apiService = new APIService();
    _profile = apiService.readProfile(_readProfile);
    updateProfileRequestModel = new UpdateProfileRequestModel();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    count = 0;
    print(_profile.then((value) => value.id));
    print(_profile.then((value) => {
          if (value.userType == 0)
            {_selectedItem = _dropdownMenuItems[1].value}
          else if(value.userType == 1)
            {_selectedItem=  ListItem(1, "Admin")}
          else
            {_selectedItem = _dropdownMenuItems[0].value}
        }));
  }

  bool validate() {
    if (updateProfileRequestModel.firstName == null ||
        updateProfileRequestModel.firstName == "") {
      showAlertDialog(context, "Error", "Fill the first name field");
      return false;
    }
    if (updateProfileRequestModel.lastName == null ||
        updateProfileRequestModel.lastName == "") {
      showAlertDialog(context, "Error", "Fill the last name field");
      return false;
    }
    if (updateProfileRequestModel.userName == null ||
        updateProfileRequestModel.userName == "") {
      showAlertDialog(context, "Error", "Fill the username field");
      return false;
    }
    if (updateProfileRequestModel.email == null ||
        updateProfileRequestModel.email == "") {
      showAlertDialog(context, "Error", "Fill the email field");
      return false;
    }
    if (updateProfileRequestModel.address == null ||
        updateProfileRequestModel.address == "") {
      showAlertDialog(context, "Error", "Fill the address field");
      return false;
    }
    if (updateProfileRequestModel.phoneNumber == null ||
        updateProfileRequestModel.phoneNumber == "") {
      showAlertDialog(context, "Error", "Fill the phone number field");
      return false;
    }
    return true;
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return UserLayout(
      child: SingleChildScrollView(
        child: FutureBuilder<ReadProfileResponseModel>(
            future: _profile,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var user = snapshot.data;
                updateProfileRequestModel.id = user.id.toString();
                updateProfileRequestModel.firstName = user.firstName;
                updateProfileRequestModel.lastName = user.lastName;
                updateProfileRequestModel.userName = user.userName;
                updateProfileRequestModel.email = user.email;
                updateProfileRequestModel.address = user.address;
                updateProfileRequestModel.phoneNumber = user.phoneNumber.toString();
                updateProfileRequestModel.userType =
                    _selectedItem.value.toString();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.03),
                    Text(
                      "Update " + user.userName + "'s Profile",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.03),
                    RoundedInputField(
                      hintText: "First Name",
                      onChanged: (value) =>
                          {updateProfileRequestModel.firstName = value},
                      text: user.firstName,
                    ),
                    RoundedInputField(
                      hintText: "Last Name",
                      onChanged: (value) =>
                          {updateProfileRequestModel.lastName = value},
                      text: user.lastName,
                    ),
                    RoundedInputField(
                      hintText: "Username",
                      onChanged: (value) =>
                          {updateProfileRequestModel.userName = value},
                      text: user.userName,
                    ),
                    RoundedInputField(
                      hintText: "Email",
                      onChanged: (value) =>
                          {updateProfileRequestModel.email = value},
                      text: user.email,
                    ),
                    RoundedInputField(
                      hintText: "Address",
                      onChanged: (value) =>
                          {updateProfileRequestModel.address = value},
                      text: user.address,
                    ),
                    RoundedInputField(
                      hintText: "Phone",
                      onChanged: (value) =>
                          {updateProfileRequestModel.phoneNumber = value.toString()},
                      text: user.phoneNumber.toString(),
                    ),
                    (id != '1' && userType == '1')
                        ? TextFieldContainer(
                            child: Row(
                              children: <Widget>[
                                Text('User Type'),
                                SizedBox(width: size.width * 0.03),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
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
                          )
                        : Container(),
                    RoundedButton(
                      text: "UPDATE",
                      press: () {
                        if (validate()) {
                          updateProfileRequestModel.id = id;
                          APIService apiService = new APIService();
                          apiService
                              .updateProfile(updateProfileRequestModel)
                              .then((value) async {
                            if (value.message == "Profile Update.") {
                              showAlertDialogByIdType(context, "Update Success",
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
                );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
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
                return ProfileScreen(id: id, userType: userType);
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
