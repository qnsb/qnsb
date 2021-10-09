class DeleteProfileResponseModel {
  final String message;

  DeleteProfileResponseModel({
    this.message,
  });

  factory DeleteProfileResponseModel.fromJson(json) {
    return DeleteProfileResponseModel(
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class DeleteProfileRequestModel {
  String id;

  DeleteProfileRequestModel({this.id});
}
