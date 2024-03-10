import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:raj_lines/data/response/api_resopnse.dart';
import 'package:raj_lines/model/product_details_model.dart';
import 'package:raj_lines/repository/details_repository.dart';
import 'package:raj_lines/utils/utils.dart';

class ProductDetailsProvider with ChangeNotifier {
  final _productByCategory = ProductDetailsRepository();

  ApiResponse<ProductDetailsModel> poductDetails = ApiResponse.loading();

  setHomeData(ApiResponse<ProductDetailsModel> response) {
    poductDetails = response;
    notifyListeners();
  }

  Future<void> fetchProductDetailsData(String id) async {
    setHomeData(ApiResponse.loading());

    _productByCategory.fetchProductDetails(id).then((value) {
      log(value.toString(), name: 'product details');
      setHomeData(ApiResponse.loading());

      setHomeData(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setHomeData(ApiResponse.error(error.toString()));
    });
  }

  Future<void> favroiteAndUnfavroiteApi(
      dynamic data, BuildContext context) async {
    log(data['productId']);
    _productByCategory.favroiteOrUnfavroite(data).then((value) {
      _productByCategory.fetchProductDetails(data['productId']).then((value) {
        setHomeData(ApiResponse.completed(value));
      });
      if (kDebugMode) {
        print('favUnfav-------${value.toString()}');
      }
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
