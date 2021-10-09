class ReadAllBookedServiceResponseModel {
  List<Service> services;
  String message;

  ReadAllBookedServiceResponseModel({
    this.services,
    this.message
  });

  factory ReadAllBookedServiceResponseModel.fromJson(json) {
    if(json[0]!=null){
      return ReadAllBookedServiceResponseModel(
        services: List<Service>.from(json.map((x) => Service.fromJson(x))));
    }else{
        return ReadAllBookedServiceResponseModel(
        message: "No Availlable Date Found");
    }
  }
}

class Service {
  int bookingID;
  String serviceName;
  String availableDate;

  Service({
    this.bookingID,
    this.serviceName,
    this.availableDate,
  });
  factory Service.fromJson(json) {
    return Service(
      bookingID: json["bookingID"],
      serviceName: json["serviceName"],
      availableDate: json["availableDate"]
    );
  }

  Map<String, dynamic> toJson() => {
        "bookingID": bookingID,
        "serviceName": serviceName,
        "availableDate": availableDate
      };
}
