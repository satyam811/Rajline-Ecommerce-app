import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:raj_lines/data/response/api_resopnse.dart';
import 'package:raj_lines/model/home_model.dart';
import 'package:raj_lines/repository/home_repository.dart';

import '../model/banner_model.dart';

class HomeProvider with ChangeNotifier {
  final _home = HomeRepository();

  ApiResponse<GetMainCategory> homeData = ApiResponse.loading();
  ApiResponse<List<BannerModel>> bannerData = ApiResponse.loading();

  setHomeData(ApiResponse<GetMainCategory> response) {
    homeData = response;
    notifyListeners();
  }

  setBannerData(ApiResponse<List<BannerModel>> response) {
    bannerData = response;
    notifyListeners();
  }

  Future<void> fetchHomeData() async {
    setHomeData(ApiResponse.loading());

    _home.fetchData().then((value) {
      log(value.toString(), name: 'Home');
      setHomeData(ApiResponse.loading());

      setHomeData(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setHomeData(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchBannerData() async {
    setBannerData(ApiResponse.loading());

    _home.fetchBannerData().then((value) {
      log(value.toString(), name: 'Home');
      setBannerData(ApiResponse.loading());

      setBannerData(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setBannerData(ApiResponse.error(error.toString()));
    });
  }
}
