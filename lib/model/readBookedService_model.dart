import 'dart:convert';

class ReadBookedServiceResponseModel {
  List<Service> services;
  String message;

  ReadBookedServiceResponseModel({
    this.services,
    this.message
  });

  factory ReadBookedServiceResponseModel.fromJson(json) {
    if(json[0]!=null){
      return ReadBookedServiceResponseModel(
          services: List<Service>.from(json.map((x) => Service.fromJson(x)))
      );
    }else{
      return ReadBookedServiceResponseModel(
        message: 'No Services Booked' 
      );
    }
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
}


class ReadBookedServiceRequestModel {
  String userID;

  ReadBookedServiceRequestModel({
    this.userID,
  });
}