import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/UpdateService/components/body.dart';

class UpdateServiceScreen extends StatelessWidget {
  final String id;

  UpdateServiceScreen({this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(id: id),
    );
  }
}
