import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:raj_lines/provider/auth_provider.dart';
import 'package:raj_lines/res/colors.dart';
import 'package:raj_lines/view/auth/forgot_password_screen.dart';
import 'package:raj_lines/view/widgets/auth_logo.dart';
import 'package:raj_lines/view/widgets/custom_textfield.dart';

import '../widgets/password_fied.dart';
import 'registration/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;

  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  _signIn() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (_formKey.currentState?.validate() ?? false) {
      Map data = {
        'email': _emailController.text,
        'password': _passwordController.text,
      };
      authProvider.loginApi(data, context);

      // Navigator.of(context).pushAndRemoveUntil(
      //   MaterialPageRoute(
      //     builder: (context) => const MainScreen(),
      //   ),
      //   (route) => false,
      // );
    }
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
                // SizedBox(
                //   height: 28.h,
                // ),
                Text(
                  'Sign In',
                  style:
                      GoogleFonts.poppins(fontSize: 22.sp, color: Colors.black),
                ),
                SizedBox(height: 17.h),
                Text(
                  'Hi! welcome back, you’ve been missed',
                  style: GoogleFonts.poppins(
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
                          label: 'Password',
                        ),
                      ],
                    )),
                // SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(),
                      ));
                    },
                    child: Text(
                      'Forgot your password?',
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
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
                        onPressed: authProvider.signInLoading ? () {} : _signIn,
                        child: authProvider.signInLoading
                            ? const CircularProgressIndicator(
                                color: AppColor.white,
                              )
                            : const Text('Sign In'))),
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 77.w,
                      color: AppColor.textfieldBorderColor.withOpacity(0.9),
                      height: 1,
                    ),
                    Text(
                      '  Or sign in with  ',
                      style: GoogleFonts.poppins(
                          color: const Color(0xff7B7B7B), fontSize: 9.sp),
                    ),
                    Container(
                      width: 77.w,
                      color: AppColor.textfieldBorderColor.withOpacity(0.9),
                      height: 1,
                    )
                  ],
                ),
                SizedBox(
                  height: 21.h,
                ),
                Container(
                  height: 54.h,
                  width: 54.h,
                  padding: EdgeInsets.all(15.h),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: SvgPicture.asset('assets/icons/google_icon.svg'),
                ),
                SizedBox(
                  height: 33.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account? ',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                        )),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegistrationScreen(),
                            ));
                      },
                      child: Text(
                        'Sign Up ',
                        style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
