import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:raj_lines/data/network/base_api_services.dart';
import 'package:raj_lines/data/network/network_api_services.dart';

import 'package:raj_lines/model/wishlist_model.dart';
import 'package:raj_lines/res/app_urls.dart';

class WishlistRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<WishlistModel> wishlistData() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.getWishlistUrl);
      log(response.toString(), name: 'get wishlist');
      return response = WishlistModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}
