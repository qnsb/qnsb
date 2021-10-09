// To parse this JSON data, do
//
//     final readAllResponseModel = readAllResponseModelFromJson(jsonString);

import 'dart:convert';

List<ReadAllResponseModel> readAllResponseModelFromJson(String str) =>
    List<ReadAllResponseModel>.from(
        json.decode(str).map((x) => ReadAllResponseModel.fromJson(x)));

class ReadAllResponseModel {
  
  List<User> users;

  ReadAllResponseModel({
    this.users,
  });


  factory ReadAllResponseModel.fromJson(json) {
    return ReadAllResponseModel(
        users: List<User>.from(json.map((x) => User.fromJson(x))));
  }
}

class User {
  int id;
  String firstName;
  String lastName;
  String userName;
  String email;
  String address;
  int phoneNumber;
  int userType;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.address,
    this.phoneNumber,
    this.userType,
  });
  factory User.fromJson(json){
    return User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        userName: json["userName"],
        email: json["email"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        userType: json["userType"],
      );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "userName": userName,
        "email": email,
        "address": address,
        "phoneNumber": phoneNumber,
        "userType": userType,
      };
}
