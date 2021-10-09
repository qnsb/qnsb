// To parse this JSON data, do
//
//     final readAllServiceResponseModel = readAllServiceResponseModelFromJson(jsonString);

import 'dart:convert';

List<ReadAllServiceResponseModel> readAllServiceResponseModelFromJson(
        String str) =>
    List<ReadAllServiceResponseModel>.from(
        json.decode(str).map((x) => ReadAllServiceResponseModel.fromJson(x)));

class ReadAllServiceResponseModel {
  List<Service> services;

  ReadAllServiceResponseModel({
    this.services,
  });

  factory ReadAllServiceResponseModel.fromJson(json) {
    return ReadAllServiceResponseModel(
        services: List<Service>.from(json.map((x) => Service.fromJson(x))));
  }
}

class Service {
  int id;
  String serviceName;
  String serviceDescription;
  int servicePrice;

  Service({
    this.id,
    this.serviceName,
    this.serviceDescription,
    this.servicePrice
  });
  factory Service.fromJson(json) {
    return Service(
      id: json["id"],
      serviceName: json["serviceName"],
      serviceDescription: json["serviceDescription"],
      servicePrice: json["servicePrice"]
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "serviceName": serviceName,
        "serviceDescription": serviceDescription,
        "servicePrice": servicePrice
      };
}
