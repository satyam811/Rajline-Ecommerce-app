import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:raj_lines/data/response/api_resopnse.dart';
import 'package:raj_lines/model/order_model.dart';
import 'package:raj_lines/model/wishlist_model.dart';
import 'package:raj_lines/repository/order_repository.dart';
import 'package:raj_lines/repository/wishlist_repository.dart';

class OrderProvider with ChangeNotifier {
  final _wishlistData = OrderRepository();

  ApiResponse<OrderModel> orderData = ApiResponse.loading();

  setOrderData(ApiResponse<OrderModel> response) {
    orderData = response;
    notifyListeners();
  }

  Future<void> fetchOrderData() async {
    setOrderData(ApiResponse.loading());

    _wishlistData.orderData().then((value) {
      log(value.toString(), name: 'orderlist');
      setOrderData(ApiResponse.loading());

      setOrderData(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setOrderData(ApiResponse.error(error.toString()));
    });
  }
}
