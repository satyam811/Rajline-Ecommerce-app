import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:raj_lines/data/response/api_resopnse.dart';
import 'package:raj_lines/model/category_model.dart';
import 'package:raj_lines/repository/category_repository.dart';

class CategoryProvider with ChangeNotifier {
  final _subCategory = CategoryRepository();

  ApiResponse<GetSubCategoryMain> subCategory = ApiResponse.loading();

  setHomeData(ApiResponse<GetSubCategoryMain> response) {
    subCategory = response;
    notifyListeners();
  }

  Future<void> fetchHomeData(String id) async {
    setHomeData(ApiResponse.loading());

    _subCategory.fetchSubCategoryData(id).then((value) {
      log(value.toString(), name: 'sub category');
      setHomeData(ApiResponse.loading());

      setHomeData(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setHomeData(ApiResponse.error(error.toString()));
    });
  }
}
