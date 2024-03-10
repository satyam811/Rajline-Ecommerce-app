import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:raj_lines/data/network/base_api_services.dart';
import 'package:raj_lines/data/network/network_api_services.dart';
import 'package:raj_lines/model/banner_model.dart';
import 'package:raj_lines/model/home_model.dart';
import 'package:raj_lines/res/app_urls.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<GetMainCategory> fetchData() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.mainCategoryUul);
      log(response.toString(), name: 'Home');
      return response = GetMainCategory.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<List<BannerModel>> fetchBannerData() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.banner);
      log(response.toString(), name: 'banner');
      return response = (response['banners'] as List)
          .map((e) => BannerModel.fromJson(e))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}
