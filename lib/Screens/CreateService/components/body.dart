import 'package:flutter/material.dart';
import 'package:flutter_a1/Screens/UserAdmin/admin_screen.dart';
import 'package:flutter_a1/components/alertDialogBox.dart';
import 'package:flutter_a1/components/rounded_button.dart';
import 'package:flutter_a1/components/rounded_input_field.dart';
import 'package:flutter_a1/components/text_field_container.dart';
import 'package:flutter_a1/components/userLayout.dart';
import 'package:flutter_a1/model/createService_model.dart';
import 'package:flutter_a1/api/api_service.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CreateServiceRequestModel createServiceRequestModel;

  @override
  void initState() {
    super.initState();
    createServiceRequestModel = new CreateServiceRequestModel();
  }

  bool validate() {
    if (createServiceRequestModel.serviceName == null ||
        createServiceRequestModel.serviceName == "") {
      showAlertDialog(context, "Error", "Fill the service name field");
      return false;
    }
    if (createServiceRequestModel.serviceDescription == null ||
        createServiceRequestModel.serviceDescription == "") {
      showAlertDialog(context, "Error", "Fill the service description field");
      return false;
    }
      if (createServiceRequestModel.servicePrice == null ||
        createServiceRequestModel.servicePrice == "") {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            Text(
              "Create Service",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Service Name",
              onChanged: (value) =>
                  {createServiceRequestModel.serviceName = value},
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
                onChanged: (value) =>
                    {createServiceRequestModel.serviceDescription = value},
                ),  
            ),
            RoundedInputField(
              hintText: "Service Price",
              onChanged: (value) =>
                  {createServiceRequestModel.servicePrice = value},
              icon: Icons.price_change
            ),
            RoundedButton(
              text: "CREATE",
              press: () async {
                if (validate()) {
                  APIService apiService = new APIService();
                  apiService
                      .createService(createServiceRequestModel)
                      .then((value) async {
                    if (value.message == "service created") {
                      showAlertDialog(context, "Create Success", value.message);
                    } else {
                      showAlertDialog(context, "Error", value.message);
                    }
                  });
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
          ],
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
                return AdminScreen();
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
