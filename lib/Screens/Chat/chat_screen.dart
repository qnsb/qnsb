import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/Chat/components/body.dart';

class ChatScreen extends StatelessWidget {
  final String id;

  ChatScreen({this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(chatRoomId: id),
    );
  }
}
