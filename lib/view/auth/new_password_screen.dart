import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:raj_lines/provider/auth_provider.dart';
import 'package:raj_lines/res/colors.dart';
import 'package:raj_lines/utils/utils.dart';
import 'package:raj_lines/view/widgets/auth_logo.dart';
import 'package:raj_lines/view/widgets/password_fied.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen(
      {super.key, required this.email, required this.otpId});
  final String email;
  final String otpId;

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _confPasswordController;

  late final TextEditingController _passwordController;
  late TextEditingController _fieldOne;
  late TextEditingController _fieldTwo;
  late TextEditingController _fieldThree;
  late TextEditingController _fieldFour;

  @override
  void initState() {
    _confPasswordController = TextEditingController();
    _passwordController = TextEditingController();
    _fieldOne = TextEditingController();
    _fieldTwo = TextEditingController();
    _fieldThree = TextEditingController();
    _fieldFour = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confPasswordController.dispose();
    _fieldOne.dispose();
    _fieldTwo.dispose();
    _fieldThree.dispose();
    _fieldFour.dispose();
    super.dispose();
  }

  String? otp;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                const AuthLogo(),
                Text(
                  'New Password',
                  style:
                      GoogleFonts.poppins(fontSize: 22.sp, color: Colors.black),
                ),
                SizedBox(height: 17.h),

                Text(
                  'Please enter the code we just sent to email',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: AppColor.lightGreyTextColor,
                  ),
                ),
                Text(
                  widget.email,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: AppColor.lightGreyTextColor,
                  ),
                ),
                SizedBox(
                  height: 52.h,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OtpInput(_fieldOne, true),
                            SizedBox(width: 9.w), // auto focus
                            OtpInput(_fieldTwo, false),
                            SizedBox(width: 9.w),
                            OtpInput(_fieldThree, false),
                            SizedBox(width: 9.w),
                            OtpInput(_fieldFour, false),
                          ],
                        ),
                        SizedBox(
                          height: 26.h,
                        ),
                        PasswordField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter password";
                            }
                            RegExp regex = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                            if (!regex.hasMatch(value)) {
                              return "enter valid password";
                            }
                            return null;
                          },
                          controller: _passwordController,
                          hintText: '****************',
                          label: 'New Password',
                        ),
                        PasswordField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please confirm password";
                            }
                            RegExp regex = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                            if (!regex.hasMatch(value)) {
                              return "enter valid password";
                            }
                            if (_passwordController.text !=
                                _confPasswordController.text) {
                              return "please enter same password";
                            }
                            return null;
                          },
                          controller: _confPasswordController,
                          hintText: '****************',
                          label: 'Confirm Password',
                        ),
                      ],
                    )),
                // SizedBox(height: 8.h),

                SizedBox(height: 33.h),
                SizedBox(
                    height: 41.h,
                    width: double.infinity,
                    child: ElevatedButton(
                        // onPressed: () {
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => MainScreen(),
                        //   ));
                        // },
                        onPressed: authProvider.resetPasswordLoading
                            ? () {}
                            : () {
                                if (_fieldOne.text.isEmpty ||
                                    _fieldTwo.text.isEmpty ||
                                    _fieldThree.text.isEmpty ||
                                    _fieldFour.text.isEmpty) {
                                  Utils.flushBarErrorMessage(
                                      'Please enter varification code',
                                      context);
                                  return;
                                }
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  otp =
                                      '${_fieldOne.text}${_fieldTwo.text}${_fieldThree.text}${_fieldFour.text}';
                                  Map data = {
                                    'otpId': widget.otpId,
                                    'otp': otp,
                                    'newPassword': _confPasswordController.text
                                  };
                                  authProvider.resetPassword(data, context);
                                }
                              },
                        child: authProvider.resetPasswordLoading
                            ? const CircularProgressIndicator(
                                color: AppColor.white,
                              )
                            : const Text('Change Password'))),
                SizedBox(
                  height: 50.h,
                ),

                SizedBox(
                  height: 21.h,
                ),

                SizedBox(
                  height: 33.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const OtpInput(this.controller, this.autoFocus, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46.h,
      width: 44.w,
      child: TextField(
        style: TextStyle(fontSize: 22.h),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
          constraints: BoxConstraints(
            maxHeight: 8.h,
            minHeight: 8.h,
            maxWidth: 15.w,
            minWidth: 15.w,
          ),
        ),
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        inputFormatters: [LengthLimitingTextInputFormatter(1)],
        cursorColor: Theme.of(context).primaryColor,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
