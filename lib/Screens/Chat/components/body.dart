import 'package:flutter/material.dart';
import 'package:flutter_a1/components/userLayout.dart';
import 'package:flutter_a1/components/chat.dart';

class Body extends StatefulWidget {
  final String chatRoomId;
  
  Body({this.chatRoomId});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  
  @override
  Widget build(BuildContext context) {
    return UserLayout(
      child: Chat(chatRoomId: widget.chatRoomId),
      bottomNavigationBar: null,
    );
  }

}
