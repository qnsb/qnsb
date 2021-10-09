import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/Profile/components/body.dart';

class ProfileScreen extends StatelessWidget {
  final String id;
  final String userType;
  ProfileScreen({this.id, this.userType});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(id: id, userType: userType),
    );
  }
}
