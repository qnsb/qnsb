class DeleteServiceResponseModel {
  final String message;

  DeleteServiceResponseModel({
    this.message,
  });

  factory DeleteServiceResponseModel.fromJson(json) {
    return DeleteServiceResponseModel(
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class DeleteServiceRequestModel {
  String id;

  DeleteServiceRequestModel({this.id});
}
