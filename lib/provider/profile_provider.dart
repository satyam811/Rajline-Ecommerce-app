import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:raj_lines/data/response/api_resopnse.dart';
import 'package:raj_lines/model/user_model.dart';
import 'package:raj_lines/repository/profile_repository.dart';
import 'package:raj_lines/utils/utils.dart';

class ProfileProvider with ChangeNotifier {
  final _userData = ProfileRepository();

  ApiResponse<UserModel> userData = ApiResponse.loading();

  setUserData(ApiResponse<UserModel> response) {
    userData = response;
    notifyListeners();
  }

  bool _verifyCodeLoading = false;
  bool get verifyCodeLoading => _verifyCodeLoading;

  setSignInLoading(bool value) {
    _verifyCodeLoading = value;
    notifyListeners();
  }

  Future<void> fetchUserData() async {
    setUserData(ApiResponse.loading());

    _userData.getUserData().then((value) {
      log(value.toString(), name: 'wishlist');
      setUserData(ApiResponse.loading());

      setUserData(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setUserData(ApiResponse.error(error.toString()));
    });
  }

  Future<void> upadateUserData(dynamic data, BuildContext context) async {
    setSignInLoading(true);

    _userData.updateUserData(data, context).then((value) {
      // log(value.toString(), name: 'wishlist');
      setSignInLoading(false);
      setUserData(ApiResponse.completed(value));
      Utils.toastMessage('Profile update successfull');
    }).onError((error, stackTrace) {
      setUserData(ApiResponse.error(error.toString()));
      setSignInLoading(false);
    });
  }
}
