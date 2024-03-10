import 'package:flutter/material.dart';

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);

  Future<dynamic> getPostApiResponse(
      String url, dynamic data, BuildContext context);

  Future<dynamic> getPutApiResponse(String url, dynamic data);

  Future<dynamic> getDeleteApiResponse(String url, BuildContext context);

  Future<dynamic> getPatchApiResponse(
      String url, dynamic data, BuildContext context);
}
