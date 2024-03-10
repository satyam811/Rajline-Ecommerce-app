import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:raj_lines/data/response/api_resopnse.dart';
import 'package:raj_lines/model/wishlist_model.dart';
import 'package:raj_lines/repository/wishlist_repository.dart';

class WishlistProvider with ChangeNotifier {
  final _wishlistData = WishlistRepository();

  ApiResponse<WishlistModel> wishlistData = ApiResponse.loading();

  setWishlistData(ApiResponse<WishlistModel> response) {
    wishlistData = response;
    notifyListeners();
  }

  Future<void> fetchWishlistData() async {
    setWishlistData(ApiResponse.loading());

    _wishlistData.wishlistData().then((value) {
      log(value.toString(), name: 'wishlist');
      setWishlistData(ApiResponse.loading());

      setWishlistData(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setWishlistData(ApiResponse.error(error.toString()));
    });
  }
}
