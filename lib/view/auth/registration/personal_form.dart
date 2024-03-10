import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:raj_lines/provider/auth_provider.dart';
import 'package:raj_lines/res/colors.dart';
import 'package:raj_lines/view/widgets/auth_logo.dart';
import 'package:raj_lines/view/widgets/custom_textfield.dart';
import 'package:raj_lines/view/widgets/step_widget.dart';

class PersonalForm extends StatefulWidget {
  const PersonalForm(
      {super.key,
      required this.email,
      required this.name,
      required this.password,
      required this.phoneNumber});
  final String email;
  final String name;
  final String password;
  final String phoneNumber;
  @override
  State<PersonalForm> createState() => _PersonalFormState();
}

class _PersonalFormState extends State<PersonalForm> {
  late final TextEditingController _shopNameController;
  late final TextEditingController _addressController;
  late final TextEditingController _districtController;
  late final TextEditingController _pincodeController;
  late final TextEditingController _stateController;
  late final TextEditingController _gstController;
  late final TextEditingController _cityController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _shopNameController = TextEditingController();
    _addressController = TextEditingController();
    _districtController = TextEditingController();
    _pincodeController = TextEditingController();
    _stateController = TextEditingController();
    _gstController = TextEditingController();
    _cityController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _shopNameController.dispose();
    _addressController.dispose();
    _districtController.dispose();
    _pincodeController.dispose();
    _stateController.dispose();
    _gstController.dispose();
    _cityController.dispose();
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
              const StepWidgetRow(index: '2'),
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
                            return "please enter shop name";
                          }
                          return null;
                        },
                        controller: _shopNameController,
                        label: 'Shop Name',
                        hintText: 'name',
                        keyboardType: TextInputType.text,
                      ),
                      CustomTextField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter address";
                          }
                          return null;
                        },
                        controller: _addressController,
                        hintText: 'Address',
                        label: 'Address',
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "please enter district";
                                }

                                return null;
                              },
                              controller: _districtController,
                              hintText: '',
                              label: 'Disrict',
                            ),
                          ),
                          SizedBox(
                            width: 9.w,
                          ),
                          Expanded(
                            child: CustomTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "please enter Town/city name";
                                }

                                return null;
                              },
                              controller: _cityController,
                              hintText: '',
                              label: 'Town/City',
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "please enter state";
                                }

                                return null;
                              },
                              controller: _stateController,
                              hintText: '',
                              label: 'State',
                            ),
                          ),
                          SizedBox(
                            width: 9.w,
                          ),
                          Expanded(
                            child: CustomTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "please enter pin code";
                                }

                                return null;
                              },
                              controller: _pincodeController,
                              hintText: '',
                              label: 'Pin Code',
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      CustomTextField(
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "please enter GST No.";
                        //   }
                        //   return null;
                        // },
                        controller: _gstController,
                        hintText: '',
                        label: 'GST No.',
                        keyboardType: TextInputType.number,
                        isOpt: true,
                      ),
                    ],
                  )),
              SizedBox(height: 23.h),
              SizedBox(
                  height: 41.h,
                  width: double.infinity,
                  child: ElevatedButton(
                      // onPressed: () {
                      //   if (_formKey.currentState?.validate() ?? false) {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (_) => OtpVerificationScreen(
                      //                   email: widget.email,
                      //                 )));
                      //   }
                      // },
                      onPressed: authProvider.signUpLoading
                          ? () {}
                          : () {
                              if (_formKey.currentState?.validate() ?? false) {
                                Map data = {
                                  'email': widget.email,
                                  'name': widget.name,
                                  'password': widget.password,
                                  'mobileNumber': widget.phoneNumber,
                                  'address': _addressController.text,
                                  'district': _districtController.text,
                                  'city': _cityController.text,
                                  'pinCode': _pincodeController.text,
                                  'state': _stateController.text,
                                  'gstNo': _gstController.text,
                                  'shopName': _shopNameController.text,
                                };
                                authProvider.registerApi(data, context);
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (_) => OtpVerificationScreen(
                                //               email: widget.email,
                                //             )));
                              }
                            },
                      child: authProvider.signUpLoading
                          ? const CircularProgressIndicator(
                              color: AppColor.white,
                            )
                          : const Text('Submit')))
            ],
          ),
        ),
      )),
    );
  }

  Container buildHorizontalLine() {
    return Container(
      color: AppColor.blueButtonColor,
      height: 2,
      width: 80.w,
    );
  }
}
