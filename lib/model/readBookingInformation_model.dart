class ReadBookingInformationResponseModel {
  final int bookingID;
  final String firstName;
  final String lastName;
  final String email;
  final String userName;
  final String address;
  final int phoneNumber;
  final String serviceName;
  final String serviceDescription;
  final int servicePrice;
  final String message;

  ReadBookingInformationResponseModel({
    this.bookingID,
    this.firstName,
    this.lastName,
    this.email,
    this.userName,
    this.address,
    this.phoneNumber,
    this.serviceName,
    this.serviceDescription,
    this.servicePrice,
    this.message,
  });

  factory ReadBookingInformationResponseModel.fromJson(json) {
    print(json);

    return ReadBookingInformationResponseModel(
      bookingID: json["bookingID"] != null ? json["bookingID"] : "",
      firstName: json["firstName"] != null ? json["firstName"] : "",
      lastName: json["lastName"] != null ? json["lastName"] : "",
      email: json["email"] != null ? json["email"] : "",
      address: json["address"] != null ? json["address"] : "",
      userName: json["userName"] != null ? json["userName"] : "",
      phoneNumber: json["phoneNumber"] != null ? json["phoneNumber"] : "",
      serviceName: json["serviceName"] != null ? json["serviceName"] : "",
      serviceDescription: json["serviceDescription"] != null ? json["serviceDescription"] : "",
      servicePrice: json["servicePrice"] != null ? json["servicePrice"] : "",
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class ReadBookingInformationRequestModel {
  String id;

  ReadBookingInformationRequestModel({
    this.id,
  });
}
