import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/UpdateProfile/update_profile_screen.dart';
import 'package:flutter_a1/Screens/UserAdmin/admin_screen.dart';
import 'package:flutter_a1/Screens/UserCustomer/customer_screen.dart';
import 'package:flutter_a1/Screens/UserStaff/staff_screen.dart';
import 'package:flutter_a1/api/api_service.dart';
import 'package:flutter_a1/components/alertIdType.dart';
import 'package:flutter_a1/components/rounded_button.dart';
import 'package:flutter_a1/components/userLayout.dart';
import 'package:flutter_a1/model/deleteProfile_model.dart';
import 'package:flutter_a1/model/readProfile_model.dart';

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
  ReadProfileRequestModel _readProfile;
  Future<ReadProfileResponseModel> _profile;
  _BodyState({this.id, this.userType});

  @override
  void initState() {
    _readProfile = new ReadProfileRequestModel();
    _readProfile.id = id;
    APIService apiService = new APIService();
    _profile = apiService.readProfile(_readProfile);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us t\
    // otal height and width of our screen
    return UserLayout(
        child: FutureBuilder<ReadProfileResponseModel>(
            future: _profile,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var user = snapshot.data;
                var type;
                var userid = user.id.toString();
                if (user.userType == 1) {
                  type = 'Admin';
                } else if (user.userType == 2) {
                  type = 'Staff';
                } else if (user.userType == 0) {
                  type = 'Customer';
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.06),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          user.firstName + "'s profile",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Name',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          ' : ',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          user.firstName + ' ' + user.lastName,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Username',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          ' : ',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          user.userName,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Email',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          ' : ',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          user.email,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Address',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          ' : ',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          user.address,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Phone Number',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          ' : ',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          user.phoneNumber.toString(),
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'User Type',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          ' : ',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          type,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    RoundedButton(
                      text: "UPDATE",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return UpdateProfileScreen(
                                  id: userid, userType: userType);
                            },
                          ),
                        );
                      },
                    ),
                    (userType == '1' && id != '1')
                        ? RoundedButton(
                            text: "Delete",
                            color: Colors.red,
                            textColor: Colors.white,
                            press: () {
                              DeleteProfileRequestModel
                                  deleteProfileRequestModel =
                                  new DeleteProfileRequestModel();
                              deleteProfileRequestModel.id = id;
                              APIService apiService = new APIService();
                              apiService
                                  .deleteProfile(deleteProfileRequestModel)
                                  .then((value) async {
                                if (value.message == "User Deleted.") {
                                  showAlertDialogByIdType(
                                      context,
                                      "Delete Success",
                                      value.message,
                                      id,
                                      userType);
                                }
                              });
                            },
                          )
                        : SizedBox(height: size.height * 0.03),
                    SizedBox(height: size.height * 0.03),
                  ],
                );
              }else{
                return Center(
                  child: CircularProgressIndicator());
              }
            }),
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
