class CreateUserResponseModel {
  final String message;

  CreateUserResponseModel({
    this.message,
  });

  factory CreateUserResponseModel.fromJson(json) {
    return CreateUserResponseModel(
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class CreateUserRequestModel {
  String firstName;
  String lastName;
  String email;
  String userName;
  String password;
  String confirmPassword;
  String address;
  String phoneNumber;
  String userType;

  CreateUserRequestModel(
      {this.firstName,
      this.lastName,
      this.email,
      this.userName,
      this.password,
      this.confirmPassword,
      this.address,
      this.phoneNumber,
      this.userType});
}
