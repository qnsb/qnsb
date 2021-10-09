import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/UpdateDate/update_date_screen.dart';
import 'package:flutter_a1/Screens/UpdateService/update_service_screen.dart';
import 'package:flutter_a1/Screens/UserAdmin/admin_screen.dart';
import 'package:flutter_a1/Screens/UserCustomer/customer_screen.dart';
import 'package:flutter_a1/api/api_service.dart';
import 'package:flutter_a1/components/alertIdType.dart';
import 'package:flutter_a1/components/rounded_button.dart';
import 'package:flutter_a1/components/userLayout.dart';
import 'package:flutter_a1/model/bookService_model.dart';
import 'package:flutter_a1/model/cancelService_model.dart';
import 'package:flutter_a1/model/deleteDate_model.dart';
import 'package:flutter_a1/model/deleteService_model.dart';
import 'package:flutter_a1/model/readService_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  String id;

  Body({Key key, @required this.id}) : super(key: key);
  @override
  _BodyState createState() => _BodyState(id: id);
}

class _BodyState extends State<Body> {
  String id;
  String userID;
  String userType;
  ReadServiceRequestModel _readService;
  Future<ReadServiceResponseModel> _service;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  _BodyState({this.id});

  @override
  void initState(){
    _readService = new ReadServiceRequestModel();
    _readService.id = id;
    APIService apiService = new APIService();
    _service = apiService.readService(_readService);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    setUser();
  }

  void setUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString("id");
    userType = prefs?.getString("userType");
  }

  String getDate(String date){
    var formatDate= DateTime.parse(date);
    var day = formatDate.day<10 ? '0'+ formatDate.day.toString() : formatDate.day;
    var month = formatDate.month<10 ? '0'+ formatDate.month.toString() : formatDate.month;
    return day.toString()+'/'+month.toString()+'/'+formatDate.year.toString();
  }


  String getTime(String date){
    var formatDate= DateTime.parse(date);
    var ampm = formatDate.hour>12 ? 'PM':'AM';
    var hour = formatDate.hour%12;
    hour = hour!=0 ? hour : 12;
    var hours = hour<10 ? '0'+hour.toString(): hour;
    var minutes= formatDate.minute<10 ? '0'+formatDate.minute.toString() : formatDate.minute;
    return hours.toString()+':'+minutes.toString()+' '+ampm;
  }

  String getAvailability(int id){
    return id==null ?  'Book' : userID==id.toString() ? 'Cancel' : 'Not Available';
  }

  Future<void> sendPushMessage(title,body) async {
    try {
      await http.post(
        Uri.parse('https://firebase-qnsb.herokuapp.com/sendnotifications'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'body':body,'title':title}),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us t\
    // otal height and width of our screen
    return UserLayout(
        child: SingleChildScrollView(
          child: FutureBuilder<ReadServiceResponseModel>(
              future: _service,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var service = snapshot.data;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: size.height * 0.06),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            service.serviceName,
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            service.serviceDescription,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '\$'+service.servicePrice.toString(),
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      (userType == '1' ) ?
                      RoundedButton(
                        text: "UPDATE",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return UpdateServiceScreen(
                                    id: service.id.toString());
                              },
                            ),
                          );
                        },
                      ) : Container(),
                      (userType == '1' ) ?
                      RoundedButton(
                        text: "Delete",
                        color: Colors.red,
                        textColor: Colors.white,
                        press: () {
                          DeleteServiceRequestModel deleteServiceRequestModel =
                              new DeleteServiceRequestModel();
                          deleteServiceRequestModel.id = id;
                          APIService apiService = new APIService();
                          apiService
                              .deleteService(deleteServiceRequestModel)
                              .then((value) async {
                            if (value.message == "Service Deleted.") {
                              showAlertDialogByIdType(context, "Delete Success",
                                  value.message, userID, '1');
                            }
                          });
                        },
                      ): Container(),
                      SizedBox(height: size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Available Date',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      (service?.availableDate[0].dateID!=null && userType=='1') ?
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                        itemCount: service.availableDate.length,
                        itemBuilder: (context, index) {
                          var date = service.availableDate[index];
                          return Slidable( //enable slidable in list
                              key: Key(date.dateID.toString()), //set key
                              // you have to set key, other wise, after removing item from list, -
                              // - slidable will be opened. 
                              actionPane: SlidableDrawerActionPane(),
                              actionExtentRatio: 0.15,
                              child: Card(
                                child:ListTile( 
                                  title: Text(getDate(date.availableDate)+'    '+getTime(date.availableDate)),
                                ),
                              ),
                              secondaryActions: [ //action button to show on tail
                                  ElevatedButton( 
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.redAccent
                                    ),
                                    child: Icon(Icons.delete),
                                    onPressed: (){
                                      DeleteDateRequestModel deleteDateRequestModel =
                                      new DeleteDateRequestModel();
                                      deleteDateRequestModel.id = date.dateID.toString();
                                      APIService apiService = new APIService();
                                      apiService
                                          .deleteDate(deleteDateRequestModel)
                                          .then((value) async {
                                        if (value.message == "Date Deleted.") {
                                          showAlertDialogByIdType(context, value.message,
                                              value.message, id, '1');
                                        }
                                      });
                                    },
                                  ),
                              ],
                          );
                        }
                        )
                        : (service?.availableDate[0].dateID!=null) ?
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                        itemCount: service.availableDate.length,
                        itemBuilder: (context, index) {
                          var date = service.availableDate[index];
                          return Slidable( //enable slidable in list
                              key: Key(date.dateID.toString()), //set key
                              // you have to set key, other wise, after removing item from list, -
                              // - slidable will be opened. 
                              actionPane: SlidableDrawerActionPane(),
                              actionExtentRatio: 0.15,
                              child: Card(
                                child:ListTile( 
                                  onTap: () async {
                                    APIService apiService = new APIService();
                                    
                                    if(getAvailability(date.userID)=='Book'){
                                      BookServiceRequestModel bookServiceRequestModel =
                                      new BookServiceRequestModel();
                                      bookServiceRequestModel.id = date.dateID.toString();
                                      bookServiceRequestModel.userID = userID;
                                      apiService
                                          .bookService(bookServiceRequestModel)
                                          .then((value) async {
                                        if (value.message == "Service Booked.") {
                                          showAlertDialogByIdType(context, "Service Booked",
                                              value.message, id, '1');
                                          var title = service.serviceName+" Service has been booked";
                                          var body = getDate(date.availableDate)+'    '+getTime(date.availableDate);
                                          flutterLocalNotificationsPlugin.show(
                                          0,
                                          title,
                                          body,
                                          NotificationDetails(
                                              android: AndroidNotificationDetails( 
                                                 'high_importance_channel', // id 
                                                 'High Importance Notifications', // title
                                                 'This channel is used for important notifications.', 
                                                  importance: Importance.high,
                                                  color: Colors.blue,
                                                  playSound: true,
                                                  icon: '@mipmap/ic_launcher')));
                                          sendPushMessage(title,body);
                                        }
                                      });
                                    }
                                    if(getAvailability(date.userID)=='Cancel'){
                                      CancelServiceRequestModel cancelServiceRequestModel =
                                      new CancelServiceRequestModel();
                                      var title = service.serviceName+" Service has been cancelled";
                                      var body = getDate(date.availableDate)+'    '+getTime(date.availableDate);
                                      cancelServiceRequestModel.id = date.dateID.toString();
                                      apiService
                                          .cancelService(cancelServiceRequestModel)
                                          .then((value) async {
                                        if (value.message == "Service Cancelled.") {
                                          showAlertDialogByIdType(context, "Service Cancelled",
                                          value.message, id, '1');
                                          flutterLocalNotificationsPlugin.show(
                                          0,
                                          title,
                                          body,
                                          NotificationDetails(
                                              android: AndroidNotificationDetails(
                                                  'high_importance_channel', // id 
                                                 'High Importance Notifications', // title
                                                 'This channel is used for important notifications.', 
                                                  importance: Importance.high,
                                                  color: Colors.blue,
                                                  playSound: true,
                                                  icon: '@mipmap/ic_launcher')));
                                          sendPushMessage(title,body);
                                        }
                                      });
                                    }
                                  },
                                  title: RichText(
                                  text: TextSpan(
                                    text: getDate(date.availableDate)+'    '+getTime(date.availableDate)+'           ',
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '  '+getAvailability(date.userID), 
                                        style: TextStyle(fontWeight: FontWeight.bold, color: getAvailability(date.userID)=="Book" ? Colors.green : Colors.red)
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ),
                        );
                        }
                        )
                        : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'No Date Available',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      (userType == '1' ) ?
                      RoundedButton(
                        text: "Add Available Date",
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return UpdateDateScreen(
                                    id: service.id.toString(), serviceName:service.serviceName);
                              },
                            ),
                          );
                        },
                      ): Container(),
                      SizedBox(height: size.height * 0.03),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                backgroundColor: Colors.blue),
          ],
          onTap: (i) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  if(userType=='1'){
                    return AdminScreen();
                  }else{
                    return CustomerScreen(userID: userID);
                  }
                },
              ),
            );
          },
        ));
  }
}
