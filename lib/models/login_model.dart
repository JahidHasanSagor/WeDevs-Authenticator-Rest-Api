class LoginResponseModel {
  String token;
  String userNicename;

  LoginResponseModel({this.token, this.userNicename});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'] as String,
      userNicename: json['user_nicename'] as String,
    );
  }

  String getToken() {
    return token;
  }
}



class LoginRequestModel {
  String username;
  String password;

  LoginRequestModel({
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      "username": username,
      // "email": "email",
      "password": password,
    };

    return data;
  }
}
