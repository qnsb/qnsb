import 'package:flutter/material.dart';
import 'package:flutter_a1/model/bookService_model.dart';
import 'package:flutter_a1/model/cancelService_model.dart';
import 'package:flutter_a1/model/createDate_model.dart';
import 'package:flutter_a1/model/createService_model.dart';
import 'package:flutter_a1/model/createUser_model.dart';
import 'package:flutter_a1/model/deleteDate_model.dart';
import 'package:flutter_a1/model/deleteProfile_model.dart';
import 'package:flutter_a1/model/deleteService_model.dart';
import 'package:flutter_a1/model/readAllBookedService.dart';
import 'package:flutter_a1/model/readAll_model.dart';
import 'package:flutter_a1/model/readAllService_model.dart';
import 'package:flutter_a1/model/readBookedService_model.dart';
import 'package:flutter_a1/model/readBookingInformation_model.dart';
import 'package:flutter_a1/model/readService_model.dart';
import 'package:flutter_a1/model/readTotalPrice_model.dart';
import 'package:flutter_a1/model/readUser_model.dart';
import 'package:flutter_a1/model/resetPassword_model.dart';
import 'package:flutter_a1/model/signup_model.dart';
import 'package:flutter_a1/model/updateService_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_a1/model/login_model.dart';
import 'package:flutter_a1/model/readProfile_model.dart';
import 'package:flutter_a1/model/updateProfile_model.dart';

class APIService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/users/Login.php";
    String body = '{"userName": "' +
        requestModel.userName +
        '", "password": "' +
        requestModel.password +
        '"}';

    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<CreateUserResponseModel> createUser(
      CreateUserRequestModel requestModel) async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/users/Create.php";
    String body = '{"firstName": "' +
        requestModel.firstName +
        '", "lastName": "' +
        requestModel.lastName +
        '", "userName": "' +
        requestModel.userName +
        '", "email": "' +
        requestModel.email +
        '", "password": "' +
        requestModel.password +
        '", "address": "' +
        requestModel.address +
        '", "phoneNumber": "' +
        requestModel.phoneNumber +
        '", "userType": "' +
        requestModel.userType +
        '"}';

    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return CreateUserResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<SignupResponseModel> signup(SignupRequestModel requestModel) async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/users/Create.php";
    String body = '{"firstName": "' +
        requestModel.firstName +
        '", "lastName": "' +
        requestModel.lastName +
        '", "userName": "' +
        requestModel.userName +
        '", "email": "' +
        requestModel.email +
        '", "password": "' +
        requestModel.password +
        '", "address": "' +
        requestModel.address +
        '", "phoneNumber": "' +
        requestModel.phoneNumber +
        '"}';

    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return SignupResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<ReadProfileResponseModel> readProfile(
      ReadProfileRequestModel requestModel) async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/users/ReadProfile.php";
    String body = '{"id": "' + requestModel.id + '"}';

    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return ReadProfileResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<ReadAllResponseModel> readAll() async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/users/Readall.php";
    var client = http.Client();

    try {
      var response = await client.get(url);
      if (response.statusCode == 200 || response.statusCode == 400) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        return ReadAllResponseModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (Exception) {
      return Exception;
    }
  }

  Future<UpdateProfileResponseModel> updateProfile(
      UpdateProfileRequestModel requestModel) async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/users/Update.php";
    String body = '{"id": "' +
        requestModel.id +
        '", "firstName": "' +
        requestModel.firstName +
        '", "lastName": "' +
        requestModel.lastName +
        '", "userName": "' +
        requestModel.userName +
        '", "email": "' +
        requestModel.email +
        '", "address": "' +
        requestModel.address +
        '", "phoneNumber": "' +
        requestModel.phoneNumber +
        '", "userType": "' +
        requestModel.userType +
        '"}';

    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return UpdateProfileResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<DeleteProfileResponseModel> deleteProfile(
      DeleteProfileRequestModel requestModel) async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/users/Delete.php";
    String body = '{"id": "' + requestModel.id + '"}';

    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return DeleteProfileResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<ResetPasswordResponseModel> resetPassword(
      ResetPasswordRequestModel requestModel) async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/users/ResetPassword.php";
    String body = '{"id": "' +
        requestModel.id +
        '", "oldPassword": "' +
        requestModel.oldPassword +
        '", "password": "' +
        requestModel.password +
        '"}';

    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return ResetPasswordResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<CreateServiceResponseModel> createService(
      CreateServiceRequestModel requestModel) async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/services/Create.php";
    String body = '{"serviceName": "' +
        requestModel.serviceName +
        '", "serviceDescription": "' +
        requestModel.serviceDescription +
        '", "servicePrice": "' +
        requestModel.servicePrice +
        '"}';

    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return CreateServiceResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<ReadServiceResponseModel> readService(
      ReadServiceRequestModel requestModel) async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/services/ReadService.php";
    String body = '{"id": "' + requestModel.id + '"}';

    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return ReadServiceResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<ReadAllServiceResponseModel> readAllService() async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/services/Readall.php";
    var client = http.Client();

    try {
      var response = await client.get(url);
      if (response.statusCode == 200 || response.statusCode == 400) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        return ReadAllServiceResponseModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (Exception) {
      return Exception;
    }
  }
  
  Future<UpdateServiceResponseModel> updateService(
      UpdateServiceRequestModel requestModel) async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/services/Update.php";
    String body = '{"id": "' +
        requestModel.id +
        '", "serviceName": "' +
        requestModel.serviceName +
        '", "serviceDescription": "' +
        requestModel.serviceDescription +
        '", "servicePrice": "' +
        requestModel.servicePrice +
        '"}';

    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return UpdateServiceResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  
  Future<DeleteServiceResponseModel> deleteService(
      DeleteServiceRequestModel requestModel) async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/services/Delete.php";
    String body = '{"id": "' + requestModel.id + '"}';

    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return DeleteServiceResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<CreateDateResponseModel> createDate(
      CreateDateRequestModel requestModel) async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/bookings/Create.php";
    String body = '{"serviceID": "' +
        requestModel.serviceID +
        '", "availableDate": "' +
        requestModel.availableDate +
        '"}';

    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return CreateDateResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

   Future<DeleteDateResponseModel> deleteDate(
      DeleteDateRequestModel requestModel) async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/bookings/Delete.php";
    String body = '{"id": "' + requestModel.id + '"}';

    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return DeleteDateResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<BookServiceResponseModel> bookService(
      BookServiceRequestModel requestModel) async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/bookings/Book.php";
    String body = '{"id": "' +
        requestModel.id +
        '", "userID": "' +
        requestModel.userID +
        '"}';

    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return BookServiceResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }


  Future<CancelServiceResponseModel> cancelService(
      CancelServiceRequestModel requestModel) async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/bookings/Cancel.php";
    String body = '{"id": "' +
        requestModel.id +
        '"}';

    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return CancelServiceResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<ReadBookedServiceResponseModel> readBookedService(ReadBookedServiceRequestModel requestModel) async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/bookings/ReadBookedService.php";
    String body = '{"userID": "' +
      requestModel.userID +
    '"}';

    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return ReadBookedServiceResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }


  Future<ReadAllBookedServiceResponseModel> readAllBookedService() async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/bookings/ReadAllBookedService.php";
    var client = http.Client();

    try {
      var response = await client.get(url);
      if (response.statusCode == 200 || response.statusCode == 400) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        return ReadAllBookedServiceResponseModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (Exception) {
      return Exception;
    }
  }

   Future<ReadBookingInformationResponseModel> readBookingInformation(
      ReadBookingInformationRequestModel requestModel) async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/bookings/BookingInformation.php";
    String body = '{"bookingID": "' + requestModel.id + '"}';

    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return ReadBookingInformationResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<ReadTotalPriceResponseModel> readTotalPrice(ReadTotalPriceRequestModel requestModel) async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/bookings/ReadTotalPrice.php";
    String body = '{"userID": "' +
      requestModel.userID +
    '"}';

    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return ReadTotalPriceResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }


  Future<ReadUserResponseModel> readUser(String search) async {
    String url =
        "https://queen-nails-spa-and-beauty.herokuapp.com/api/users/ReadUser.php";
    String body = '{"userName": "' +
      search +
    '"}';

    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return ReadUserResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

}
