import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/ChangePassword/components/body.dart';

class ChangePasswordScreen extends StatelessWidget {
  final String id;
  final String userType;

  ChangePasswordScreen({this.id, this.userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(id: id, userType: userType),
    );
  }
}
