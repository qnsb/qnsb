class UpdateProfileResponseModel {
  final String message;

  UpdateProfileResponseModel({
    this.message,
  });

  factory UpdateProfileResponseModel.fromJson(json) {
    return UpdateProfileResponseModel(
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class UpdateProfileRequestModel {
  String id;
  String firstName;
  String lastName;
  String email;
  String userName;
  String address;
  String phoneNumber;
  String userType;

  UpdateProfileRequestModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.userName,
    this.address,
    this.phoneNumber,
    this.userType,
  });
}
