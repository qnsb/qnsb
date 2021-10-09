class ResetPasswordResponseModel {
  final String message;

  ResetPasswordResponseModel({
    this.message,
  });

  factory ResetPasswordResponseModel.fromJson(json) {
    return ResetPasswordResponseModel(
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class ResetPasswordRequestModel {
  String id;
  String oldPassword;
  String confirmPassword;
  String password;

  ResetPasswordRequestModel({this.id, this.oldPassword, this.password});
}
