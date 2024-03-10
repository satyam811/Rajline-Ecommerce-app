import '../data/network/network_api_services.dart';
import 'package:flutter/material.dart';

import '../data/network/base_api_services.dart';
import '../res/app_urls.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data, BuildContext context) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.signInUrl, data, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> registerApi(dynamic data, BuildContext context) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.signUpUrl, data, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> verifyCodeApi(dynamic data, BuildContext context) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.verifyCode, data, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> resendCodeApi(dynamic data, BuildContext context) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.resendCode, data, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> forgotApi(dynamic data, BuildContext context) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.forgotPassword, data, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> resetPasswordCodeApi(
      dynamic data, BuildContext context) async {
    try {
      dynamic response = await _apiServices.getPatchApiResponse(
          AppUrl.resetPassword, data, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Future<dynamic> changePasswordApi(dynamic data, BuildContext context) async {
  //   try {
  //     dynamic response = await _apiServices.getPostApiResponse(
  //         AppUrl.changePassword, data, context);
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<dynamic> deleteAccountApi(BuildContext context) async {
  //   try {
  //     dynamic response = await _apiServices.getDeleteApiResponse(
  //         AppUrl.deleteAccount, context);
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
