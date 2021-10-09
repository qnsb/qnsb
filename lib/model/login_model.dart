class LoginResponseModel {
  final String id;
  final String userType;
  final String message;

  LoginResponseModel({
    this.id,
    this.userType,
    this.message,
  });

  factory LoginResponseModel.fromJson(json) {
    return LoginResponseModel(
      id: json["id"] != null ? json["id"].toString() : "",
      userType: json["userType"] != null ? json["userType"].toString() : "",
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class LoginRequestModel {
  String userName;
  String password;

  LoginRequestModel({
    this.userName,
    this.password,
  });
}
