import 'package:flutter/material.dart';
import 'package:raj_lines/data/network/base_api_services.dart';
import 'package:raj_lines/data/network/network_api_services.dart';

import 'package:raj_lines/res/app_urls.dart';

class PaymentRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> placeOrderPayment(dynamic data, BuildContext context) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.paymentOrderUrl, data, context);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
