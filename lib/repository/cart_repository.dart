import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:raj_lines/data/network/base_api_services.dart';
import 'package:raj_lines/data/network/network_api_services.dart';
import 'package:raj_lines/model/cart_model.dart';
import 'package:raj_lines/res/app_urls.dart';

class CartRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<GetCartModel> cartListData() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.getCartlisturl);
      log(response.toString(), name: 'get cartlist');
      return response = GetCartModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<dynamic> quntityUpdate(
      dynamic data, String productId, BuildContext context) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          '${AppUrl.updateQuntityUrl}$productId', data, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteFromCart(String productId, BuildContext context) async {
    try {
      dynamic response = await _apiServices.getDeleteApiResponse(
          '${AppUrl.updateQuntityUrl}$productId', context);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
