import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/BookingInfo/components/body.dart';

class BookingInfoScreen extends StatelessWidget {
  final String id;
  BookingInfoScreen({this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(id: id),
    );
  }
}
