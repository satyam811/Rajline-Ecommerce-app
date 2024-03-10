import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:raj_lines/data/response/api_resopnse.dart';
import 'package:raj_lines/model/productby_category_model.dart';
import 'package:raj_lines/repository/category_details_repository.dart';

class ProductByCategoryProvider with ChangeNotifier {
  final _productByCategory = ProductByCategoryRepository();

  ApiResponse<GetProductByCategory> poductByCategory = ApiResponse.loading();

  setHomeData(ApiResponse<GetProductByCategory> response) {
    poductByCategory = response;
    notifyListeners();
  }

  Future<void> fetchHomeData(String id) async {
    setHomeData(ApiResponse.loading());

    _productByCategory.fetchProductByCategoryData(id).then((value) {
      log(value.toString(), name: 'sub category');
      setHomeData(ApiResponse.loading());

      setHomeData(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setHomeData(ApiResponse.error(error.toString()));
    });
  }
}
