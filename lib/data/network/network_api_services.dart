import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:raj_lines/data/app_exception.dart';
import 'package:raj_lines/utils/shared_prefs.dart';

import 'base_api_services.dart';

class NetworkApiService extends BaseApiServices {
  final _prefs = SharedPrefs.instance();
  @override
  Future getGetApiResponse(String url) async {
    // log(token ?? 'f', name: 't');
    if (kDebugMode) {
      print('sasaas $url');
    }
    final token = _prefs.token;
    dynamic responseJson;
    // print('headers in GetApiResponse url => $url${{
    //   "Accept": "application/json",
    //   "Content-Type": "application/x-www-form-urlencoded",
    //   "Authorization": 'Bearer $token'
    // }}');
    try {
      // log(token ?? 'no token');
      final response = await get(Uri.parse(url), headers: {
        // "Accept": "application/json",
        // "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": 'Bearer $token'
      }).timeout(const Duration(seconds: 30));
      log('message: ${response.statusCode}');
      if (kDebugMode) {
        print(response.body);
      }
      responseJson = returnResponse(response);
    } on SocketException {
      if (kDebugMode) {
        print("SocketException in GetApiResponse");
      }
      throw FetchDataException('No Internet Connectiom');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(
      String url, dynamic data, BuildContext context) async {
    final token = _prefs.token;
    if (kDebugMode) {
      print('$data, name:post api');
    }
    dynamic responseJson;
    try {
      Response response = await post(Uri.parse(url),
          body: jsonEncode(data),
          headers: {
            "Content-Type": "application/json",
            "Authorization": 'Bearer $token'
          }).timeout(const Duration(seconds: 30));
      log(response.statusCode.toString(), name: 'post api response');
      log(response.body, name: 'body');
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPutApiResponse(String url, dynamic data) async {
    final token = _prefs.token;
    if (kDebugMode) {
      print('$data, name:put api');
    }
    dynamic responseJson;

    try {
      Response response = await put(Uri.parse(url),
          body: jsonEncode(data),
          headers: {
            "Content-Type": "application/json",
            "Authorization": 'Bearer $token'
          }).timeout(const Duration(seconds: 30));
      log(response.body, name: 'put api body');

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getDeleteApiResponse(String url, BuildContext context) async {
    final token = _prefs.token;
    dynamic responseJson;
    try {
      Response response = await delete(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Authorization": 'Bearer $token'
      }).timeout(const Duration(seconds: 30));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPatchApiResponse(String url, data, BuildContext context) async {
    final token = _prefs.token;
    if (kDebugMode) {
      print('$data, name:patch api');
    }
    dynamic responseJson;
    try {
      Response response = await patch(Uri.parse(url),
          body: jsonEncode(data),
          headers: {
            "Content-Type": "application/json",
            "Authorization": 'Bearer $token'
          }).timeout(const Duration(seconds: 30));
      log(response.statusCode.toString(), name: 'patch api response');
      log(response.body, name: 'body');
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        throw BadResuestException(responseJson['message']);
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        throw UnauthorisedException(responseJson['message']);
      case 401:
        dynamic responseJson = jsonDecode(response.body);
        throw UnauthorisedException(responseJson['message']);
      case 409:
        dynamic responseJson = jsonDecode(response.body);
        throw UnauthorisedException(responseJson['message']);
      case 422:
        dynamic responseJson = jsonDecode(response.body);
        throw UnauthorisedException(responseJson['message']);

      default:
        throw FetchDataException(
            'Error occured while comunicating with server with status code${response.statusCode}');
    }
  }
}
