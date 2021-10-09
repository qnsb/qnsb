class DeleteDateResponseModel {
  final String message;

  DeleteDateResponseModel({
    this.message,
  });

  factory DeleteDateResponseModel.fromJson(json) {
    return DeleteDateResponseModel(
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class DeleteDateRequestModel {
  String id;

  DeleteDateRequestModel({this.id});
}
