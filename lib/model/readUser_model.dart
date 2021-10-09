class ReadUserResponseModel {
  List<User> users;
  String message;

  ReadUserResponseModel({
    this.users,
    this.message
  });

  factory ReadUserResponseModel.fromJson(json) {
    if(json[0]!=null){
      return ReadUserResponseModel(
          users: List<User>.from(json.map((x) => User.fromJson(x)))
      );
    }else{
      return ReadUserResponseModel(
        message: 'No Users Found' 
      );
    }
  }
}

class User {
  int id;
  String firstName;
  String lastName;
  String userName;
  String email;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.userName,
    this.email
  });

  factory User.fromJson(json){
    return User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        userName: json["userName"],
        email: json["email"]
      );
  }
}
