import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:raj_lines/main_screen.dart';
import 'package:raj_lines/repository/auth_repository.dart';
import 'package:raj_lines/res/app_urls.dart';
import 'package:raj_lines/utils/shared_prefs.dart';
import 'package:raj_lines/utils/utils.dart';
import 'package:raj_lines/view/auth/forgot_password_screen.dart';
import 'package:raj_lines/view/auth/login_screen.dart';
import 'package:raj_lines/view/auth/new_password_screen.dart';
import 'package:raj_lines/view/auth/registration/otp_verification.dart';

class AuthProvider with ChangeNotifier {
  final _prefs = SharedPrefs.instance();
  final _myRepo = AuthRepository();

  bool _signInLoading = false;
  bool get signInLoading => _signInLoading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  bool _verifyCodeLoading = false;
  bool get verifyCodeLoading => _verifyCodeLoading;

  bool _forgotPasswordLoading = false;
  bool get forgotPasswordLoading => _forgotPasswordLoading;

  bool _resetPasswordLoading = false;
  bool get resetPasswordLoading => _resetPasswordLoading;

  setSignInLoading(bool value) {
    _signInLoading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  setVerifyCodeLoading(bool value) {
    _verifyCodeLoading = value;
    notifyListeners();
  }

  setForgotPasswordLoading(bool value) {
    _forgotPasswordLoading = value;
    notifyListeners();
  }

  setResetPasswordLoading(bool value) {
    _resetPasswordLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setSignInLoading(true);
    Response response = await post(Uri.parse(AppUrl.signInUrl),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json",
        });
    var decodeData = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      setSignInLoading(false);
      _prefs.setToken(decodeData['token']);
      _prefs.setName(decodeData['user']['name']);
      _prefs.setEmail(decodeData['user']['email']);
      _prefs.setUserId(decodeData['user']['_id']);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const MainScreen(),
      ));
    } else if (response.statusCode == 401) {
      setSignInLoading(false);
      if (decodeData['message'] ==
          "Email is not verified, please verify your email") {
        String email1 = decodeData['user']['email'];
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Verify otp'),
              content: Text("${decodeData['message']}"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    String id1 = decodeData['user']['_id'];

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => OtpVerificationScreen(
                        email: email1,
                        id: id1,
                      ),
                    ));
                    Map data2 = {'userId': id1};
                    resendOtp(data2, context);
                  },
                  child: Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    // Handle No button press
                    Navigator.of(context).pop(); // Close the dialog
                    // Add your code for the No action here
                  },
                  child: Text('No'),
                ),
              ],
            );
          },
        );
      } else {
        Utils.flushBarErrorMessage(decodeData['message'], context);
      }
    } else {
      setSignInLoading(false);
      Utils.flushBarErrorMessage(decodeData['message'], context);
    }

    // _myRepo.loginApi(data, context).then((value) {
    //   setSignInLoading(false);
    //   _prefs.setToken(value['token']);
    //   _prefs.setName(value['user']['name']);
    //   _prefs.setEmail(value['user']['email']);
    //   Utils.snackBar('login successfull', context);
    //   Navigator.of(context).pushReplacement(MaterialPageRoute(
    //     builder: (context) => const MainScreen(),
    //   ));
    //   if (kDebugMode) {
    //     print('login-------${value.toString()}');
    //   }
    // }).onError((error, stackTrace) {
    //   setSignInLoading(false);
    //   Utils.flushBarErrorMessage(error.toString(), context);
    //   if (kDebugMode) {
    //     print(error.toString());
    //   }
    // });
  }

  Future<void> registerApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    _myRepo.registerApi(data, context).then((value) {
      setSignUpLoading(false);
      // _prefs.setToken(value['token']);
      // _prefs.setName(value['user']['name']);
      // _prefs.setEmail(value['user']['email']);
      if (kDebugMode) {
        print(data['email']);
      }
      String userId = value['user']['_id'];
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => OtpVerificationScreen(
          email: data['email'],
          id: userId,
        ),
      ));
      if (kDebugMode) {
        print('login-------${value.toString()}');
      }
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> verifyCodeApi(dynamic data, BuildContext context) async {
    setVerifyCodeLoading(true);
    log(data.toString());
    _myRepo.verifyCodeApi(data, context).then((value) {
      setVerifyCodeLoading(false);
      _prefs.setToken(value['token']);
      _prefs.setName(value['user']['name']);
      _prefs.setEmail(value['user']['email']);
      _prefs.setUserId(value['user']['_id']);
      // Utils.snackBar(value['message'], context);
      // Navigator.of(context).pop();
      // Navigator.pushNamed(context, RoutesName.resetPassword, arguments: email);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
        (route) => false,
      );
      if (kDebugMode) {
        print('varify:-----${value.toString()}');
      }
    }).onError((error, stackTrace) {
      setVerifyCodeLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> resendOtp(dynamic data, BuildContext context) async {
    log(data.toString());
    _myRepo.resendCodeApi(data, context).then((value) {
      // Utils.snackBar(value['message'], context);
      // Navigator.of(context).pop();
      // Navigator.pushNamed(context, RoutesName.resetPassword, arguments: email);
      Utils.toastMessage(value['message']);
      if (kDebugMode) {
        print('varify:-----${value.toString()}');
      }
    }).onError((error, stackTrace) {
      setVerifyCodeLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> forgotPassword(dynamic data, BuildContext context) async {
    log(data.toString());
    setForgotPasswordLoading(true);
    _myRepo.forgotApi(data, context).then((value) {
      setForgotPasswordLoading(false);
      // Utils.snackBar(value['message'], context);
      // Navigator.of(context).pop();
      // Navigator.pushNamed(context, RoutesName.resetPassword, arguments: email);

      Utils.toastMessage(value['message']);
      String id = value['otpId'];
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NewPasswordScreen(
            email: data['email'],
            otpId: id,
          ),
        ),
      );

      if (kDebugMode) {
        print('varify:-----${value.toString()}');
      }
    }).onError((error, stackTrace) {
      setForgotPasswordLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> resetPassword(dynamic data, BuildContext context) async {
    log(data.toString());
    setResetPasswordLoading(true);
    _myRepo.resetPasswordCodeApi(data, context).then((value) {
      setResetPasswordLoading(false);
      // Utils.snackBar(value['message'], context);
      // Navigator.of(context).pop();
      // Navigator.pushNamed(context, RoutesName.resetPassword, arguments: email);
      Utils.toastMessage(value['message']);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false);

      if (kDebugMode) {
        print('varify:-----${value.toString()}');
      }
    }).onError((error, stackTrace) {
      setResetPasswordLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
