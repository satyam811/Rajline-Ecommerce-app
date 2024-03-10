import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:raj_lines/data/network/base_api_services.dart';
import 'package:raj_lines/data/network/network_api_services.dart';
import 'package:raj_lines/model/category_model.dart';
import 'package:raj_lines/res/app_urls.dart';

class CategoryRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<GetSubCategoryMain> fetchSubCategoryData(String id) async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse('${AppUrl.subCategoryOfMainUrl}$id');
      log(response.toString(), name: 'sub category');
      return response = GetSubCategoryMain.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}
