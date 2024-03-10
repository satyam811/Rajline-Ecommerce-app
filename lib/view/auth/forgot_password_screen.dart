import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:raj_lines/provider/auth_provider.dart';
import 'package:raj_lines/res/colors.dart';
import 'package:raj_lines/view/auth/new_password_screen.dart';
import 'package:raj_lines/view/widgets/auth_logo.dart';
import 'package:raj_lines/view/widgets/custom_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;

  @override
  void initState() {
    _emailController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

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
                  'Forgot Password',
                  style:
                      GoogleFonts.poppins(fontSize: 22.sp, color: Colors.black),
                ),
                SizedBox(height: 17.h),
                // Text(
                //   'Hi! welcome back, you’ve been missed',
                //   style: GoogleFonts.poppins(
                //     fontSize: 12.sp,
                //     color: AppColor.lightGreyTextColor,
                //   ),
                // ),
                SizedBox(
                  height: 52.h,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter email";
                            }
                            final bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value);
                            if (!emailValid) {
                              return "please enter correct email";
                            }
                            return null;
                          },
                          hintText: 'example@gmail.com',
                          label: 'Email',
                        ),

                        // SizedBox(
                        //   height: 23.h,
                        // ),
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
                        onPressed: authProvider.forgotPasswordLoading
                            ? () {}
                            : () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  Map data = {
                                    'email': _emailController.text,
                                  };
                                  authProvider.forgotPassword(data, context);
                                }
                              },
                        child: authProvider.forgotPasswordLoading
                            ? const CircularProgressIndicator(
                                color: AppColor.white,
                              )
                            : const Text('Forgot Password'))),
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
