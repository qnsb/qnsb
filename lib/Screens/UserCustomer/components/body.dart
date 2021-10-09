import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/Service/service_screen.dart';
import 'package:flutter_a1/api/api_service.dart';
import 'package:flutter_a1/components/userLayout.dart';
import 'package:flutter_a1/components/chat.dart';
import 'package:flutter_a1/model/readAllService_model.dart';
import 'package:flutter_a1/model/readBookedService_model.dart';
import 'package:flutter_a1/model/readTotalPrice_model.dart';
import 'package:flutter_a1/services/firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  final String userID;

  Body({Key key, this.userID}) : super(key: key);

  @override
  _BodyState createState() => _BodyState(userID:userID);
}

class _BodyState extends State<Body> {
  int _currentIndex = 0;
  String userID;
  Future<ReadAllServiceResponseModel> _readAllServiceModel;
  Future<ReadBookedServiceResponseModel> _readBookedServiceModel;
  Future<ReadTotalPriceResponseModel> _readTotalPriceModel;
  ReadBookedServiceRequestModel _readBookedServiceRequestModel;
  ReadTotalPriceRequestModel _readTotalPriceRequestModel;

  _BodyState({this.userID});

  @override
  void initState() {
    super.initState();
    setUser();
    _readAllServiceModel = APIService().readAllService();
  }

  void setUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString("id");
    _readBookedServiceRequestModel = new ReadBookedServiceRequestModel();
    _readBookedServiceRequestModel.userID = userID;
    _readTotalPriceRequestModel = new ReadTotalPriceRequestModel();
    _readTotalPriceRequestModel.userID = userID;
    _readBookedServiceModel = APIService().readBookedService(_readBookedServiceRequestModel);
    _readTotalPriceModel = APIService().readTotalPrice(_readTotalPriceRequestModel);
  }

  tabs(currentindex, size) {
    if (currentindex == 1) {
      return Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                  'Booked Services',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                )
            ),
          ),
          Expanded(
            flex: 8,
            child: FutureBuilder(
                future: _readBookedServiceModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if(snapshot.data.message!=null){
                      return Container(child:Text('No Booked Services Found'));
                    }else{
                      return ListView.builder(
                          itemCount: snapshot.data.services.length,
                          itemBuilder: (context, index) {
                            var services = snapshot.data.services[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1.0, horizontal: 4.0),
                              child: Card(
                                child: ListTile(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ServiceScreen(
                                              id: services.id.toString()
                                        );
                                        },
                                      ),
                                    );
                                  },
                                  title: new RichText(
                                    text: new TextSpan(
                                      style: new TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        new TextSpan(
                                            text: services.id.toString() + '.  '),
                                        new TextSpan(
                                            text: services.serviceName,
                                            style: new TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                        }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: FutureBuilder<ReadTotalPriceResponseModel>(
                future: _readTotalPriceModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      'Total Estimated Cost : \$'+snapshot.data.totalPrice.toString(),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    );
                  } else {
                    return Text(
                      'Total Estimated Cost : \$0',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    );
                  }
                }
              )
            ),
          ),
        ],
      );
    } else if(currentindex==0){
      return Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                  'Services',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                )
            ),
          ),
          Expanded(
            flex: 9,
            child: FutureBuilder(
                future: _readAllServiceModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.services.length,
                        itemBuilder: (context, index) {
                          var services = snapshot.data.services[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 4.0),
                            child: Card(
                              child: ListTile(
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ServiceScreen(
                                            id: services.id.toString()
                                      );
                                      },
                                    ),
                                  );
                                },
                                title: new RichText(
                                  text: new TextSpan(
                                    style: new TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      new TextSpan(
                                          text: services.id.toString() + '.  '),
                                      new TextSpan(
                                          text: services.serviceName,
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      );
    }else{
      Map<String, String> chatRoom = {
        "user": userID!=null ? userID.toString() : '0'
      };

      CloudFireStore().addChatRoom(chatRoom, userID.toString());
      return Chat(chatRoomId: userID);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return UserLayout(
      child: tabs(_currentIndex, size),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              title: Text('Services'),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.design_services),
              title: Text('Booked Services'),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.message),
              title: Text('Message'),
              backgroundColor: Colors.blue),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
