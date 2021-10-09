import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/CreateService/create_user_screen.dart';
import 'package:flutter_a1/Screens/CreateUser/create_user_screen.dart';
import 'package:flutter_a1/Screens/Service/service_screen.dart';
import 'package:flutter_a1/api/api_service.dart';
import 'package:flutter_a1/components/userLayout.dart';
import 'package:flutter_a1/Screens/Profile/profile_screen.dart';
import 'package:flutter_a1/model/readAllService_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_a1/model/readAll_model.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _currentIndex = 0;
  Future<ReadAllResponseModel> _readAllModel;
  Future<ReadAllServiceResponseModel> _readAllServiceModel;

  @override
  void initState() {
    super.initState();
    _readAllModel = APIService().readAll();
    _readAllServiceModel = APIService().readAllService();
  }

  tabs(currentindex, size) {
    if (currentindex == 0) {
      return Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                color: Colors.red,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CreateUserScreen();
                      },
                    ),
                  );
                },
                child: Text(
                  'Add User',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: FutureBuilder(
                future: _readAllModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.users.length,
                        itemBuilder: (context, index) {
                          var user = snapshot.data.users[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 4.0),
                            child: Card(
                              child: ListTile(
                                onTap: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  var userType = prefs?.getString("userType");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ProfileScreen(
                                            id: user.id.toString(),
                                            userType: userType);
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
                                          text: user.id.toString() + '.  '),
                                      new TextSpan(
                                          text: user.firstName +
                                              ' ' +
                                              user.lastName,
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      new TextSpan(
                                          text: ' (' + user.userName + ')'),
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
    } else {
      return Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                color: Colors.red,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CreateServiceScreen();
                      },
                    ),
                  );
                },
                child: Text(
                  'Add Service',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
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
                                            id: services.id.toString(),
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
                                          text: services.serviceName+' ',
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      new TextSpan(
                                          text: ' \$'+services.servicePrice.toString(),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold, color: Colors.green)),
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
              icon: Icon(Icons.person),
              title: Text('Users'),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.design_services),
              title: Text('Services'),
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
