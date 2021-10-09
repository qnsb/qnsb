import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/UpdateDate/components/body.dart';

class UpdateDateScreen extends StatelessWidget {
  final String id;
  final String serviceName;

  UpdateDateScreen({this.id, this.serviceName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(id: id, serviceName: serviceName),
    );
  }
}
