import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:raj_lines/data/network/base_api_services.dart';
import 'package:raj_lines/data/network/network_api_services.dart';
import 'package:raj_lines/model/productby_category_model.dart';
import 'package:raj_lines/res/app_urls.dart';

class ProductByCategoryRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<GetProductByCategory> fetchProductByCategoryData(String id) async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse('${AppUrl.getProductByCalegoryUrl}$id');
      log(response.toString(), name: 'product by category');
      return response = GetProductByCategory.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}
