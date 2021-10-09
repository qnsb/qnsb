class SignupResponseModel {
  final String message;

  SignupResponseModel({
    this.message,
  });

  factory SignupResponseModel.fromJson(json) {
    return SignupResponseModel(
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class SignupRequestModel {
  String firstName;
  String lastName;
  String email;
  String userName;
  String password;
  String confirmPassword;
  String address;
  String phoneNumber;

  SignupRequestModel({
    this.firstName,
    this.lastName,
    this.email,
    this.userName,
    this.password,
    this.confirmPassword,
    this.address,
    this.phoneNumber,
  });
}
