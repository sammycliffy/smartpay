import 'dart:convert';
import 'dart:developer';

import 'package:smart_pay/app_services/local_storage_service.dart';
import 'package:smart_pay/constants/keys.dart';
import 'package:smart_pay/models/user_model.dart';

import '../app/locator.dart';
import 'api_client.dart';
import 'endpoints.dart';

class AuthService {
  final storage = locator<LocalStorageService>();

  Future<bool> login(
    String email,
    String password,
  ) async {
    var data = {
      "email": email,
      "password": password,
      "device_name": "mobile_phone"
    };
    final response =
        await ApiClient.post(Endpoints.login, body: data, useToken: false);

    if (response.status == true) {
      UserModel userModel = UserModel.fromJson(response.data);

      storage.saveDataToDisk(Keys.userKey, json.encode(userModel.token));
      storage.saveDataToDisk(Keys.userData, json.encode(response.data));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getEmailToken(String email) async {
    var body = {"email": email};

    final response = await ApiClient.post(Endpoints.getEmailToken,
        useToken: false, body: body);

    if (response.status == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> passwordOTP(String email, String token) async {
    var data = {"email": email, "token": token};

    final response = await ApiClient.post(Endpoints.verifyEmail, body: data);

    if (response.status == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(
    String fullName,
    String username,
    String country,
    String email,
    String password,
  ) async {
    var data = {
      "full_name": fullName,
      "username": username,
      "email": email,
      "country": country,
      "password": password,
      "device_name": "mobile_phone"
    };
    final response =
        await ApiClient.post(Endpoints.register, body: data, useToken: false);

    if (response.status == true) {
      if (response.status == true) {
        UserModel userModel = UserModel.fromJson(response.data);

        storage.saveDataToDisk(Keys.userKey, json.encode(userModel.token));
        storage.saveDataToDisk(Keys.userData, json.encode(response.data));
        return true;
      }
      return true;
    } else {
      return false;
    }
  }
}
