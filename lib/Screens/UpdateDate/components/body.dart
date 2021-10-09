import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/Service/service_screen.dart';
import 'package:flutter_a1/api/api_service.dart';
import 'package:flutter_a1/components/alertDialogBox.dart';
import 'package:flutter_a1/components/alertIdType.dart';
import 'package:flutter_a1/components/rounded_button.dart';
import 'package:flutter_a1/components/userLayout.dart';
import 'package:flutter_a1/model/createDate_model.dart';

class Body extends StatefulWidget {
  String id;
  String serviceName;

  Body({Key key, @required this.id, @required this.serviceName}) : super(key: key);
  @override
  _BodyState createState() => _BodyState(id: id);
}

class _BodyState extends State<Body> {
  String id;
  String serviceName;
  CreateDateRequestModel createDateRequestModel;

  _BodyState({this.id, this.serviceName});
  DateTime pickedDate;
  TimeOfDay time;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
    createDateRequestModel = new CreateDateRequestModel();
  }

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return UserLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.serviceName+' service',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ],
          ),
          ListTile(
            title: Text("Date: ${pickedDate.year}/${pickedDate.month}/${pickedDate.day}"),
            trailing: Icon(Icons.keyboard_arrow_down),
            onTap: _pickDate,
          ),
          ListTile(
            title: Text("Time: ${time.hour}:${time.minute}"),
            trailing: Icon(Icons.keyboard_arrow_down),
            onTap: _pickTime,
          ),
          SizedBox(height: size.height * 0.02),
          RoundedButton(
            text: "Add Date",
            color: Colors.blueAccent,
            textColor: Colors.white,
            press: () {
                APIService apiService = new APIService();
                createDateRequestModel.serviceID = id;
                var date = new DateTime(pickedDate.year,pickedDate.month,pickedDate.day,time.hour,time.minute);
                createDateRequestModel.availableDate = date.toString();
                apiService
                    .createDate(createDateRequestModel)
                    .then((value) async {
                  if (value.message == "date added") {
                    showAlertDialogByIdType(context, value.message, value.message+' succesfully', id, '1');
                  } else {
                    showAlertDialog(context, "Error", value.message);
                  }
                });
            },
          ),
        ],
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
                return ServiceScreen(id: id);
              },
            ),
          );
        },
      ),
    );
  }
  _pickDate() async {
   DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day),
      lastDate: DateTime(DateTime.now().year+5),
      initialDate: pickedDate,
    );

    if(date != null)
      setState(() {
        pickedDate = date;
      });

  }
  _pickTime() async {
   TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: time
    );

    if(t != null)
      setState(() {
        time = t;
      });

  }
}
