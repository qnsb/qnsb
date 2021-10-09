class ReadServiceResponseModel {
  final int id;
  final String serviceName;
  final String serviceDescription;
  final int servicePrice;
  final List<AvailableDate> availableDate;


  ReadServiceResponseModel({this.id, this.serviceName, this.serviceDescription, this.availableDate, this.servicePrice});

  factory ReadServiceResponseModel.fromJson(json) {
    return ReadServiceResponseModel(
        id: json["id"] != null ? json["id"] : "",
        serviceName: json["serviceName"] != null ? json["serviceName"] : "",
        serviceDescription:
            json["serviceDescription"] != null ? json["serviceDescription"] : "",
        servicePrice:
            json["servicePrice"] != null ? json["servicePrice"] : "",
        availableDate: List<AvailableDate>.from(json["availableDate"].map((x) => AvailableDate.fromJson(x))) 
        );
  }
}

class AvailableDate{

  int dateID;
  String availableDate;
  int userID;

  AvailableDate({
    this.dateID,
    this.availableDate,
    this.userID
  });
  
  factory AvailableDate.fromJson(json){
    return AvailableDate(
        dateID: json["dateID"],
        availableDate: json["availableDate"],
        userID: json["userID"]
      );
  }
  
  Map<String, dynamic> toJson() => {
        "dateID": dateID,
        "availableDate": availableDate,
        "userID": userID,
      };
}

class ReadServiceRequestModel {
  String id;

  ReadServiceRequestModel({
    this.id,
  });
}
