class CreateServiceResponseModel {
  final String message;

  CreateServiceResponseModel({
    this.message,
  });

  factory CreateServiceResponseModel.fromJson(json) {
    return CreateServiceResponseModel(
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class CreateServiceRequestModel {
  String serviceName;
  String serviceDescription;
  String servicePrice;

  CreateServiceRequestModel({this.serviceName, this.serviceDescription, this.servicePrice});
}
