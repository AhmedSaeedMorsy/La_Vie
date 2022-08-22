class UserModel {
  String? message;
  late UserData data;
  UserModel();
  UserModel.fromjson(Map<String, dynamic> json) {
    message = json["message"];
    data = UserData.fromjson(json["data"]);
  }
}

class UserData {
  late User user;
  late String accessToken;
  UserData.fromjson(Map<String, dynamic> json) {
    user = User.fromjson(json["user"]);
    accessToken = json["accessToken"];
  }
}

class User {
  late String firstName;
  late String lastName;
  late String email;
  late String imageUrl;
  User();
  User.fromjson(Map<String, dynamic> json) {
    firstName = "firstName";
    lastName = "lastName";
    email = "email";
    imageUrl = "imageUrl";
  }
}
