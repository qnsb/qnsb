class BookServiceResponseModel {
  final String message;

  BookServiceResponseModel({
    this.message,
  });

  factory BookServiceResponseModel.fromJson(json) {
    return BookServiceResponseModel(
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class BookServiceRequestModel {
  String id;
  String userID;

  BookServiceRequestModel({this.id, this.userID});
}
