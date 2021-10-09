import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/BookingInfo/bookingInfo_screen.dart';
import 'package:flutter_a1/Screens/Chat/chat_screen.dart';
import 'package:flutter_a1/Screens/Search/search_screen.dart';
import 'package:flutter_a1/api/api_service.dart';
import 'package:flutter_a1/components/userLayout.dart';
import 'package:flutter_a1/model/readAllBookedService.dart';
import 'package:flutter_a1/model/readProfile_model.dart';
import 'package:flutter_a1/services/firestore.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Stream chatRooms;
  int _currentIndex = 0;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Future<ReadAllBookedServiceResponseModel> _readAllBookedService;

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  ReadProfileRequestModel user = new ReadProfileRequestModel(); 
                  user.id = snapshot.data.docs[index].data()["user"];

                  return FutureBuilder<bool>(
                    future: CloudFireStore().checkChats(user.id),
                    builder: (context, snapshot){
                        if(snapshot.hasData && snapshot.data){
                          var responseUser = APIService().readProfile(user); 
                          
                          return FutureBuilder<ReadProfileResponseModel>(
                            future: responseUser,
                            builder: (context, snapshot) {
                              if(snapshot.hasData){
                                return ChatRoomsTile(
                                  userName: snapshot.data.userName,
                                  chatRoomId: snapshot.data.id.toString(),
                                );
                              }else{
                                return Container();
                              }
                            }
                          );
                        }else{
                          return Container();
                        }
                  });
                  
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _readAllBookedService = APIService().readAllBookedService();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                'high_importance_channel', // id
                'High Importance Notifications', // title
                'This channel is used for important notifications.', 
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
              );
            });
      }
    });

    getUserInfogetChats();
  }

  getUserInfogetChats() async {
    CloudFireStore().getUserChats().then((snapshots) {
      setState(() {
        chatRooms = snapshots;
      });
    });
  }

  Map<String, int> getDate(String date){
    var formatDate= DateTime.parse(date);
    return {'day' : formatDate.day, 'month': formatDate.month, 'year':formatDate.year, 'hour':formatDate.hour, 'minute':formatDate.minute};
  }

  tabs(currentindex, size) {
    if (currentindex == 0) {
      return Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                  'Booking Schedule',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                )
            ),
          ),
          Expanded(
            flex: 9,
            child: Scaffold(
                body: Container(
                child: FutureBuilder(
                  future: _readAllBookedService,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      if(snapshot.data.message=="No Availlable Date Found"){
                        return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'No Booked Services',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ]);
                      }else{
                        List<Appointment> meetings = <Appointment>[];
                        final DateTime dateTime = DateTime.now();

                        for(var i=0;i<snapshot.data.services.length;i++){
                          Map<String,int> d = getDate(snapshot.data.services[i].availableDate);
                          DateTime startTime =
                              DateTime(d['year'], d['month'], d['day'], d['hour'], d['minute'], 0);
                          DateTime endTime = startTime.add(const Duration(hours: 1));
                          meetings.add(Appointment(
                              startTime: startTime,
                              endTime: endTime,
                              subject: snapshot.data.services[i].serviceName,
                              notes: snapshot.data.services[i].bookingID.toString(),
                              color: Colors.blue));
                        }                      
            
                        return SfCalendar(
                          view: CalendarView.schedule,
                          allowedViews: [ 
                              CalendarView.schedule,
                              CalendarView.day,
                              CalendarView.week,
                              CalendarView.month,
                          ],
                          initialDisplayDate: DateTime(dateTime.year, dateTime.month, dateTime.day),
                          initialSelectedDate: DateTime(dateTime.year, dateTime.month, dateTime.day),
                          dataSource: MeetingDataSource(meetings),
                          onTap: (CalendarTapDetails details) {
                            dynamic appointment = details.appointments;
                            if(appointment!=null){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return BookingInfoScreen(
                                        id:appointment[0].notes);
                                  },
                                ),
                              );
                            }
                          },
                        );
                      }
                    }else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }
                ),
            ))
          ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Scaffold(
                body: Container(
                  child: chatRoomsList()
                ),
                floatingActionButton: FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SearchScreen()));
                },
              ),
            )
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
              icon: Icon(Icons.book),
              title: Text('Appointments'),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.design_services),
              title: Text('Chat Room'),
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


List<Appointment> getAppointments(){
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Board Meeting',
      color: Colors.blue));

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName,@required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ChatScreen(
            id: chatRoomId,
          )
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.white),
          ),
          color: Colors.blue[400]
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Text(userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}