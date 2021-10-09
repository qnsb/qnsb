import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/Service/components/body.dart';

class ServiceScreen extends StatelessWidget {
  final String id;
  ServiceScreen({this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(id: id),
    );
  }
}
