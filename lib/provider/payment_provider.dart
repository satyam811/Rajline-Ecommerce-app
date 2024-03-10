import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:raj_lines/repository/payment_repository.dart';
import 'package:raj_lines/utils/utils.dart';

class PaymentProvider with ChangeNotifier {
  final _paymentData = PaymentRepository();

  bool _paymentLoading = false;
  bool get paymentLoading => _paymentLoading;

  setPaymentLoading(bool value) {
    _paymentLoading = value;
    notifyListeners();
  }

  Future<bool> paymentOrder(dynamic data, BuildContext context) async {
    setPaymentLoading(true);
    return _paymentData.placeOrderPayment(data, context).then((value) {
      setPaymentLoading(false);
      Utils.toastMessage('Order Successfull');
      if (kDebugMode) {
        print('update qty-------${value.toString()}');
      }
      return true;
    }).onError((error, stackTrace) {
      setPaymentLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
      return false;
    });
  }
}
