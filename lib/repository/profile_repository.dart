import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:raj_lines/data/network/base_api_services.dart';
import 'package:raj_lines/data/network/network_api_services.dart';
import 'package:raj_lines/model/user_model.dart';
import 'package:raj_lines/res/app_urls.dart';
import 'package:raj_lines/utils/shared_prefs.dart';

class ProfileRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<UserModel> getUserData() async {
    try {
      final userId = SharedPrefs.instance().userId;
      dynamic response =
          await _apiServices.getGetApiResponse('${AppUrl.profileUrl}$userId');
      log(response.toString(), name: 'get profile');
      return response = UserModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<UserModel> updateUserData(dynamic data, BuildContext context) async {
    try {
      final userId = SharedPrefs.instance().userId;
      dynamic response = await _apiServices.getPutApiResponse(
          '${AppUrl.profileUrl}$userId', data);
      log(response.toString(), name: 'update profile');
      return response = UserModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}
