class ReadTotalPriceResponseModel {
  int totalPrice;

  ReadTotalPriceResponseModel({
    this.totalPrice,
  });

  factory ReadTotalPriceResponseModel.fromJson(json) {
    return ReadTotalPriceResponseModel(
        totalPrice: json["totalPrice"] != null ? json["totalPrice"] : 0
    );
  }
}

class ReadTotalPriceRequestModel {
  String userID;

  ReadTotalPriceRequestModel({
    this.userID,
  });
}