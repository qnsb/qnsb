import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/Profile/profile_screen.dart';
import 'package:flutter_a1/Screens/Service/service_screen.dart';
import 'package:flutter_a1/api/api_service.dart';
import 'package:flutter_a1/components/alertDialogBox.dart';
import 'package:flutter_a1/components/alertIdType.dart';
import 'package:flutter_a1/components/rounded_button.dart';
import 'package:flutter_a1/components/rounded_input_field_update.dart';
import 'package:flutter_a1/components/text_field_container.dart';
import 'package:flutter_a1/components/userLayout.dart';
import 'package:flutter_a1/model/readService_model.dart';
import 'package:flutter_a1/model/updateService_model.dart';

class Body extends StatefulWidget {
  String id;

  Body({Key key, @required this.id}) : super(key: key);
  @override
  _BodyState createState() => _BodyState(id: id);
}

class _BodyState extends State<Body> {
  String id;
  ReadServiceRequestModel _readService;
  Future<ReadServiceResponseModel> _service;
  UpdateServiceRequestModel updateServiceRequestModel;
  _BodyState({this.id});

  @override
  void initState() {
    _readService = new ReadServiceRequestModel();
    _readService.id = id;
    APIService apiService = new APIService();
    _service = apiService.readService(_readService);
    updateServiceRequestModel = new UpdateServiceRequestModel();
  }

  bool validate() {
    if (updateServiceRequestModel.serviceName == null ||
        updateServiceRequestModel.serviceName == "") {
      showAlertDialog(context, "Error", "Fill the service name field");
      return false;
    }
    if (updateServiceRequestModel.serviceDescription == null ||
        updateServiceRequestModel.serviceDescription == "") {
      showAlertDialog(context, "Error", "Fill the service description field");
      return false;
    }
    if (updateServiceRequestModel.servicePrice == null ||
        updateServiceRequestModel.servicePrice == "") {
      showAlertDialog(context, "Error", "Fill the service price field");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return UserLayout(
      child: SingleChildScrollView(
        child: FutureBuilder<ReadServiceResponseModel>(
            future: _service,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var service = snapshot.data;
                updateServiceRequestModel.id = service.id.toString();
                updateServiceRequestModel.serviceName = service.serviceName;
                updateServiceRequestModel.serviceDescription = service.serviceDescription;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.03),
                    Text(
                      "Update " + service.serviceName + " Service",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.03),
                    RoundedInputField(
                      hintText: "Service Name",
                      onChanged: (value) =>
                          {updateServiceRequestModel.serviceName = value},
                      text: service.serviceName,
                      icon: Icons.design_services
                    ),  
                     TextFieldContainer(
                      child:  TextField(  
                        decoration: InputDecoration(  
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: 'Service Description',  
                          hintText: '',  
                        ),
                        controller: TextEditingController()..text = service.serviceDescription,
                        onChanged: (value) =>
                            {updateServiceRequestModel.serviceDescription = value},
                        ),  
                    ), 
                    RoundedInputField(
                      hintText: "Service Price",
                      onChanged: (value) =>
                          {updateServiceRequestModel.servicePrice = value},
                      text: service.servicePrice.toString(),
                      icon: Icons.price_change
                    ),
                    RoundedButton(
                      text: "UPDATE",
                      press: () {
                        if (validate()) {
                          updateServiceRequestModel.id = id;
                          APIService apiService = new APIService();
                          apiService
                              .updateService(updateServiceRequestModel)
                              .then((value) async {
                            if (value.message == "Service Update.") {
                              showAlertDialogByIdType(context, "Service Update Success",
                                  value.message, id, '1');
                            } else {
                              showAlertDialog(context, "Error", value.message);
                            }
                          });
                        }
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                  ],
                );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
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
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
