class ReadProfileResponseModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String userName;
  final String address;
  final int phoneNumber;
  final int userType;
  final String message;

  ReadProfileResponseModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.userName,
    this.address,
    this.phoneNumber,
    this.userType,
    this.message,
  });

  factory ReadProfileResponseModel.fromJson(json) {
    return ReadProfileResponseModel(
      id: json["id"] != null ? json["id"] : "",
      firstName: json["firstName"] != null ? json["firstName"] : "",
      lastName: json["lastName"] != null ? json["lastName"] : "",
      email: json["email"] != null ? json["email"] : "",
      address: json["address"] != null ? json["address"] : "",
      userName: json["userName"] != null ? json["userName"] : "",
      phoneNumber: json["phoneNumber"] != null ? json["phoneNumber"] : "",
      userType: json["userType"] != null ? json["userType"] : "",
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class ReadProfileRequestModel {
  String id;

  ReadProfileRequestModel({
    this.id,
  });
}
