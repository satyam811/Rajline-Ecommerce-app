import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:raj_lines/provider/auth_provider.dart';
import 'package:raj_lines/res/colors.dart';
import 'package:raj_lines/view/widgets/auth_logo.dart';
import 'package:raj_lines/view/widgets/step_widget.dart';

import '../../../utils/utils.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen(
      {super.key, required this.email, required this.id});
  final String email;
  final String id;
  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late TextEditingController _fieldOne;
  late TextEditingController _fieldTwo;
  late TextEditingController _fieldThree;
  late TextEditingController _fieldFour;

  @override
  void initState() {
    _fieldOne = TextEditingController();
    _fieldTwo = TextEditingController();
    _fieldThree = TextEditingController();
    _fieldFour = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
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
              SizedBox(
                height: 58.h,
              ),
              Text(
                'Verify Code',
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
              SizedBox(height: 29.h),
              const StepWidgetRow(index: '3'),
              SizedBox(
                height: 29.h,
              ),
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
              Text(
                'Didn’t receive OTP?',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: AppColor.lightGreyTextColor,
                ),
              ),
              SizedBox(height: 11.h),
              InkWell(
                onTap: () {
                  Map data = {'userId': widget.id};
                  authProvider.resendOtp(data, context);
                },
                child: Text(
                  'Resend Code',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: AppColor.blueButtonColor,
                      fontSize: 12.sp,
                      decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                height: 41.h,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: authProvider.verifyCodeLoading
                        ? () {}
                        : () {
                            if (_fieldOne.text.isEmpty ||
                                _fieldTwo.text.isEmpty ||
                                _fieldThree.text.isEmpty ||
                                _fieldFour.text.isEmpty) {
                              Utils.flushBarErrorMessage(
                                  'Please enter varification code', context);
                              return;
                            }
                            otp =
                                '${_fieldOne.text}${_fieldTwo.text}${_fieldThree.text}${_fieldFour.text}';
                            Map data = {'userId': widget.id, 'otp': otp};
                            authProvider.verifyCodeApi(data, context);
                          },
                    child: authProvider.verifyCodeLoading
                        ? const CircularProgressIndicator(
                            color: AppColor.white,
                          )
                        : const Text('Verify')),
              )
            ],
          ),
        ),
      )),
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
