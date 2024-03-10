import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:raj_lines/data/network/base_api_services.dart';
import 'package:raj_lines/data/network/network_api_services.dart';
import 'package:raj_lines/model/order_model.dart';

import 'package:raj_lines/model/wishlist_model.dart';
import 'package:raj_lines/res/app_urls.dart';

class OrderRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<OrderModel> orderData() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.paymentOrderUrl);
      log(response.toString(), name: 'get order');
      return response = OrderModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}
