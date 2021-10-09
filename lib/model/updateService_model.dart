class UpdateServiceResponseModel {
  final String message;

  UpdateServiceResponseModel({
    this.message,
  });

  factory UpdateServiceResponseModel.fromJson(json) {
    return UpdateServiceResponseModel(
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class UpdateServiceRequestModel {
  String id;
  String serviceName;
  String serviceDescription;
  String servicePrice;

  UpdateServiceRequestModel({
    this.id,
    this.serviceName,
    this.serviceDescription,
    this.servicePrice
  });
}
