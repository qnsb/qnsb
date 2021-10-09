import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/UserCustomer/components/body.dart';

class CustomerScreen extends StatelessWidget {
  final String userID;

  CustomerScreen({this.userID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(userID:userID),
    );
  }
}
