class CancelServiceResponseModel {
  final String message;

  CancelServiceResponseModel({
    this.message,
  });

  factory CancelServiceResponseModel.fromJson(json) {
    return CancelServiceResponseModel(
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class CancelServiceRequestModel {
  String id;

  CancelServiceRequestModel({this.id});
}
