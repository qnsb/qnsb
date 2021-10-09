import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/Profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_a1/Screens/Login/login_screen.dart';
import 'package:flutter_a1/Screens/ChangePassword/change_password_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserLayout extends StatelessWidget {
  final Widget child;
  final Widget bottomNavigationBar;
  const UserLayout(
      {Key key, @required this.child, @required this.bottomNavigationBar})
      : super(key: key);
      
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Queen Nails Spa & Beauty"),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Image(image: AssetImage('assets/icons/logo.png')),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var id = prefs?.getString("id");
                var userType = prefs?.getString("userType");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProfileScreen(id: id, userType: userType);
                    },
                  ),
                );
                // Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var id = prefs?.getString("id");
                var userType = prefs?.getString("userType");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ChangePasswordScreen(id: id, userType: userType);
                    },
                  ),
                );
                // Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_back),
              title: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () async {
                // Update the state of the app.
                // ...
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var userType = prefs.getString('userType');

                if(userType=='2'){
                    await FirebaseMessaging.instance
                                .unsubscribeFromTopic('Staff').catchError((e){print('error subscribing');});
                }

                prefs?.remove("id");
                prefs?.remove("userType");
                Navigator.pushAndRemoveUntil(
                    context,   
                    MaterialPageRoute(builder: (BuildContext context) => LoginScreen()), 
                    (Route<dynamic> route) => false
                );
              },
            ),
          ],
        ),
      ),
      // Here i can use size.width but use double.infinity because both work as a same
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            child,
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
