import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:wedevs_task/models/login_model.dart';
import 'package:wedevs_task/models/profile_model.dart';
import 'package:wedevs_task/models/registration_model.dart';

class APIService {
  final String baseUrl = "https://apptest.dokandemo.com";

  Future<LoginResponseModel> loginResponseHttp(
      LoginRequestModel requestModel) async {
    var url = Uri.parse(baseUrl + '/wp-json/jwt-auth/v1/token');
    var response = await http.post(
      url,
      body: requestModel.toJson(),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    );

    print(response.body);
    var jsonData = jsonDecode(response.body);
    String _token = jsonData['token'];
    print(_token);

    if (response.statusCode == 200) {
      var data = LoginResponseModel.fromJson(json.decode(response.body));
      print(data);
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Try Again");
    }
  }

  
  Future<RegistrationResponseModel> registration(
      RegistrationRequestModel requestModel) async {
    print(requestModel.toJson());
    var dio = Dio();
    try {
      var response = await dio.post(
        baseUrl + '/wp-json/wp/v2/users/register',
        data: requestModel.toJson(),
        options: Options(contentType: Headers.jsonContentType),
      );

      print(response.data['message']);
      if (response.statusCode == 200 ||
          response.statusCode == 400 ||
          response.statusCode == 406) {
        print(response.data['code']);

        return RegistrationResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Please Try Again');
    }
  }

  Future<ProfileModel> updateDataGetRequest(String token, ProfileModel profileModel) async {
    
    var url = Uri.parse('https://apptest.dokandemo.com/wp-json/wp/v2/users/me');
    var response = await http.post(
      url,
      body: {'first_name': profileModel.firstName, 'last_name': profileModel.lastName},
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      return ProfileModel.fromJson(res);
    } else {
      throw Exception('Failed to retrieve profile data');
    }
  }

  
  Future<ProfileModel> updateDataPostRequest(String token) async {
    var url = Uri.parse('https://apptest.dokandemo.com/wp-json/wp/v2/users/me');
    var response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      return ProfileModel.fromJson(res);
    } else {
      throw Exception('Failed to retrieve profile data');
    }
  }
}
