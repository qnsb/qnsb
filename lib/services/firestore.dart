import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFireStore {
  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChats(String chatRoomId) async{
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }


  Future<void> addMessage(String chatRoomId, chatMessageData){

    FirebaseFirestore.instance.collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData).catchError((e){
          print(e.toString());
    });
  }

  getUserChats() async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .snapshots();
  }

  Future<bool> checkChats(chatRoomId) async{
    bool state;
    await FirebaseFirestore.instance
        .collection("chatRoom").doc(chatRoomId)
        .collection('chats')
        .get().then((value) => {
          if(value.docs.length>0){
            state = true
          }else{
            state = false
          }
        });
    return state;
  }
}