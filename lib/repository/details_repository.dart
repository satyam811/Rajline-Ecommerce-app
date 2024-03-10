import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:raj_lines/data/network/base_api_services.dart';
import 'package:raj_lines/data/network/network_api_services.dart';
import 'package:raj_lines/model/product_details_model.dart';
import 'package:raj_lines/res/app_urls.dart';

class ProductDetailsRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<ProductDetailsModel> fetchProductDetails(String id) async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse('${AppUrl.productDetailsUrl}$id');
      log(response.toString(), name: 'product details');
      return response = ProductDetailsModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<dynamic> favroiteOrUnfavroite(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPutApiResponse(AppUrl.getWishlistUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
