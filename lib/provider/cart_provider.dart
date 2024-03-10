import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:raj_lines/data/response/api_resopnse.dart';
import 'package:raj_lines/model/cart_model.dart';
import 'package:raj_lines/repository/cart_repository.dart';
import 'package:raj_lines/utils/utils.dart';

class CartProvider with ChangeNotifier {
  final _cartlistData = CartRepository();

  ApiResponse<GetCartModel> cartlistData = ApiResponse.loading();
  bool _updateLoading = false;
  bool get updateLoading => _updateLoading;

  setSignInLoading(bool value) {
    _updateLoading = value;
    notifyListeners();
  }

  setcartlistData(ApiResponse<GetCartModel> response) {
    cartlistData = response;
    notifyListeners();
  }

  Future<void> fetchCartlistData() async {
    setcartlistData(ApiResponse.loading());

    _cartlistData.cartListData().then((value) {
      log(value.toString(), name: 'cartlist');
      setcartlistData(ApiResponse.loading());

      setcartlistData(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setcartlistData(ApiResponse.error(error.toString()));
    });
  }

  Future<bool> quntityUpdate(
      dynamic data, String productId, BuildContext context) async {
    setSignInLoading(true);
    log(data['quantity'].toString());
    return _cartlistData.quntityUpdate(data, productId, context).then((value) {
      setSignInLoading(false);
      _cartlistData.cartListData().then((value) {
        setcartlistData(ApiResponse.completed(value));
      });
      if (kDebugMode) {
        print('update qty-------${value.toString()}');
      }
      return true;
    }).onError((error, stackTrace) {
      setSignInLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
      return false;
    });
  }

  Future<void> deleteFromcart(String productId, BuildContext context) async {
    _cartlistData.deleteFromCart(productId, context).then((value) {
      _cartlistData.cartListData().then((value) {
        setcartlistData(ApiResponse.completed(value));
      });
      if (kDebugMode) {
        print('update qty-------${value.toString()}');
      }
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
