import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/UpdateProfile/components/body.dart';

class UpdateProfileScreen extends StatelessWidget {
  final String id;
  final String userType;

  UpdateProfileScreen({this.id, this.userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(id: id, userType: userType),
    );
  }
}
