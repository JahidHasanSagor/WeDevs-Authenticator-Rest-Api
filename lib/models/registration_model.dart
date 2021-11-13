class RegistrationResponseModel {
   int code;
   String message;

  RegistrationResponseModel({this.code, this.message});

  factory RegistrationResponseModel.fromJson(Map<String, dynamic> json) {
    return RegistrationResponseModel(
      code: json["code"] ,
      message: json["message"],
    );
  }
}

class RegistrationRequestModel {
  
  String username;
  String email;
  String password;

  RegistrationRequestModel(
      {
      this.username,
      this.email,
      this.password});

  RegistrationRequestModel.fromJson(Map<String, dynamic> json) {
    
    username = json['username'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {

    Map<String, dynamic> data = {
      "username": username,
       "email" : email,
      "password": password,
    };

    return data;
  }
}
