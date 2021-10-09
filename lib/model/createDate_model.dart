class CreateDateResponseModel {
  final String message;

  CreateDateResponseModel({
    this.message,
  });

  factory CreateDateResponseModel.fromJson(json) {
    return CreateDateResponseModel(
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class CreateDateRequestModel {
  String serviceID;
  String availableDate;

  CreateDateRequestModel({this.serviceID, this.availableDate});
}
