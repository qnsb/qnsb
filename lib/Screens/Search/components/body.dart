import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/Chat/chat_screen.dart';
import 'package:flutter_a1/Screens/UserStaff/staff_screen.dart';
import 'package:flutter_a1/api/api_service.dart';
import 'package:flutter_a1/components/userLayout.dart';
import 'package:flutter_a1/components/widget.dart';
import 'package:flutter_a1/model/readUser_model.dart';
import 'package:flutter_a1/services/firestore.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CloudFireStore cloudFireStore = new CloudFireStore();
  bool isLoading = false;
  TextEditingController searchEditingController = new TextEditingController();
  ReadUserResponseModel searchResult;
  bool haveUserSearched = false;

  Widget userList(){
    return haveUserSearched ?  Expanded(
      child: ListView.builder(
            shrinkWrap: true,
            itemCount: searchResult.users.length,
              itemBuilder: (context, index){
                var user = searchResult.users[index];
                return userTile(
                  user.userName,
                  user.email,
                  user.id
                );
              }
      ),
    ) : Container();
  }

  initiateSearch() async {
    if(searchEditingController.text.isNotEmpty){
      setState(() {
        isLoading = true;
      });
      searchResult = await APIService().readUser(searchEditingController.text);
      setState(() {
          isLoading = false;
          haveUserSearched = true;
      });
    }
  }

  sendMessage(userID){
    Map<String, String> chatRoom = {
      "user": userID!=null ? userID.toString() : '0'
    };

    cloudFireStore.addChatRoom(chatRoom, userID.toString());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ChatScreen(id:userID.toString());
        },
      ),
    );
  }


  Widget userTile(String userName, String userEmail, int userID){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16
                ),
              ),
              Text(
                userEmail,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16
                ),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              sendMessage(userID);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(24)
              ),
              child: Text("Message",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),),
            ),
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return UserLayout(
      child: Scaffold(
        body: isLoading ? Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ) : Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  color: Colors.blue[400],
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchEditingController,
                          style: simpleTextStyle(),
                          decoration: InputDecoration(
                            hintText: "Search User",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          initiateSearch();
                        },
                        child: Container(
                          height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0x36FFFFFF),
                                  const Color(0x0FFFFFFF)
                                ],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight
                              ),
                              borderRadius: BorderRadius.circular(40)
                            ),
                            padding: EdgeInsets.all(12),
                            child: Image.asset("assets/images/search_white.png",
                              height: 25, width: 25,)),
                      )
                    ],
                  ),
                ),
                userList()
              ],
            ),
          ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_back),
              title: Text('Back'),
              backgroundColor: Colors.blue),
        ],
        onTap: (i) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return StaffScreen();
              },
            ),
          );
        },
      ),
    );
  }

}