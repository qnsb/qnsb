import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/UserStaff/staff_screen.dart';
import 'package:flutter_a1/api/api_service.dart';
import 'package:flutter_a1/components/alertIdType.dart';
import 'package:flutter_a1/components/rounded_button.dart';
import 'package:flutter_a1/components/userLayout.dart';
import 'package:flutter_a1/model/cancelService_model.dart';
import 'package:flutter_a1/model/readBookingInformation_model.dart';

class Body extends StatefulWidget {
  String id;

  Body({Key key, @required this.id}) : super(key: key);
  @override
  _BodyState createState() => _BodyState(id: id);
}

class _BodyState extends State<Body> {
  String id;
  ReadBookingInformationRequestModel _readBookingInformation;
  Future<ReadBookingInformationResponseModel> _bookingInformation;
  _BodyState({this.id});

  @override
  void initState() {
    _readBookingInformation = new ReadBookingInformationRequestModel();
    _readBookingInformation.id = id;
    APIService apiService = new APIService();
    _bookingInformation = apiService.readBookingInformation(_readBookingInformation);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return UserLayout(
        child: FutureBuilder<ReadBookingInformationResponseModel>(
            future: _bookingInformation,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var info = snapshot.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.06),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Booked By",
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
                          info.firstName + ' ' + info.lastName,
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
                          info.userName,
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
                          info.email,
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
                          info.address,
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
                          info.phoneNumber.toString(),
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Service',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Service Name',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          ' : ',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          info.serviceName,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Service Description',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          ' : ',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          info.serviceDescription,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Service Price',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          ' : ',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          info.servicePrice.toString(),
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    RoundedButton(
                      text: "Cancel Booking",
                      color: Colors.red,
                      textColor: Colors.white,
                      press: () {
                        CancelServiceRequestModel cancelServiceRequestModel = new CancelServiceRequestModel();
                        APIService apiService = new APIService();
                        cancelServiceRequestModel.id = id;
                        apiService
                            .cancelService(cancelServiceRequestModel)
                            .then((value) async {
                          if (value.message == "Service Cancelled.") {
                            showAlertDialogByIdType(context, "Service Cancelled Staff",value.message, id, '2');
                          }
                        });
                      },
                    ),
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
                    return StaffScreen();
                },
              ),
            );
          },
        ));
  }
}
