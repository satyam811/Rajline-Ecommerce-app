import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raj_lines/res/colors.dart';

import 'package:raj_lines/view/widgets/auth_logo.dart';
import 'package:raj_lines/view/widgets/custom_textfield.dart';
import 'package:raj_lines/view/widgets/step_widget.dart';

import '../../widgets/password_fied.dart';
import 'personal_form.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _mobileNumberController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _mobileNumberController = TextEditingController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                'Create Account',
                style:
                    GoogleFonts.poppins(fontSize: 22.sp, color: Colors.black),
              ),
              SizedBox(height: 17.h),
              Text(
                'Fill your information below or register with your social account',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: AppColor.lightGreyTextColor,
                ),
              ),
              SizedBox(height: 29.h),
              const StepWidgetRow(index: '1'),
              SizedBox(
                height: 29.h,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter name";
                        }
                        return null;
                      },
                      controller: _nameController,
                      hintText: 'Name',
                      label: 'Name',
                    ),
                    CustomTextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
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
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter mobile number";
                        }
                        if (value.length != 10) {
                          return "please enter correct mobile number";
                        }
                        return null;
                      },
                      controller: _mobileNumberController,
                      label: 'Mobile Number',
                      hintText: '9999999999',
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
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
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 23.h),
              SizedBox(
                height: 41.h,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (kDebugMode) {
                      print(_formKey.currentState?.validate());
                    }
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PersonalForm(
                            email: _emailController.text,
                            name: _nameController.text,
                            password: _passwordController.text,
                            phoneNumber: _mobileNumberController.text,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Next'),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
