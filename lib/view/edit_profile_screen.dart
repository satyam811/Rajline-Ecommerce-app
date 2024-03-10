import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:raj_lines/data/response/status.dart';
import 'package:raj_lines/provider/profile_provider.dart';
import 'package:raj_lines/res/colors.dart';
import 'package:raj_lines/view/widgets/custom_textfield.dart';

import '../utils/upload_image.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;

  late final TextEditingController _nameController;
  late final TextEditingController _mobileNumberController;
  late final TextEditingController _shopNameController;
  late final TextEditingController _addressController;
  late final TextEditingController _districtController;
  late final TextEditingController _pincodeController;
  late final TextEditingController _stateController;
  late final TextEditingController _gstController;
  late final TextEditingController _cityController;
  File? selectedFile;

  @override
  void initState() {
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _mobileNumberController = TextEditingController();
    _shopNameController = TextEditingController();
    _addressController = TextEditingController();
    _districtController = TextEditingController();
    _pincodeController = TextEditingController();
    _stateController = TextEditingController();
    _gstController = TextEditingController();
    _cityController = TextEditingController();
    Future.delayed(Duration.zero, () {
      context.read<ProfileProvider>().fetchUserData();
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    _shopNameController.dispose();
    _addressController.dispose();
    _districtController.dispose();
    _pincodeController.dispose();
    _stateController.dispose();
    _gstController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<XFile?> showBottom(context) async {
    return await showModalBottomSheet<XFile?>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useRootNavigator: false,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                // height: 590.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        InkWell(
                          onTap: () async {
                            final picker = ImagePicker();
                            final pickedFile = await picker.pickImage(
                                source: ImageSource.gallery);
                            Navigator.pop(context, pickedFile);

                            // Get.back();
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.image),
                              SizedBox(
                                width: 10.w,
                              ),
                              const Text('Gallary')
                            ],
                          ),
                        ),
                        const Divider(
                            // thickness: 1,
                            color: Colors.grey),
                        SizedBox(
                          height: 10.h,
                        ),
                        InkWell(
                          onTap: () async {
                            final picker = ImagePicker();
                            final pickedFile = await picker.pickImage(
                                source: ImageSource.camera);
                            Navigator.pop(context, pickedFile);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.camera_alt),
                              SizedBox(
                                width: 10.w,
                              ),
                              const Text('camera')
                            ],
                          ),
                        ),
                        const Divider(
                          // thickness: 1,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProfileProvider>(builder: (context, value, child) {
        switch (value.userData.status) {
          case Status.loading:
            return const Center(child: CircularProgressIndicator());
          case Status.completed:
            _emailController.text = value.userData.data!.user.email;
            _nameController.text = value.userData.data!.user.name;
            _mobileNumberController.text =
                value.userData.data!.user.mobileNumber;
            _addressController.text =
                value.userData.data!.user.address.addressLine1;
            _shopNameController.text = value.userData.data!.user.shopName;
            _districtController.text = value.userData.data!.user.address.state;
            _stateController.text = value.userData.data!.user.address.state;
            _pincodeController.text = value.userData.data!.user.address.pincode;
            _gstController.text = value.userData.data!.user.gstNo;
            _cityController.text = value.userData.data!.user.address.city;
            return SizedBox(
              height: double.infinity,
              child: Stack(
                children: [
                  Container(
                    height: 181.h + 45.h,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xff12C1B1), Color(0xff0C68AD)])),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 21.w, right: 21.w, top: 45.h),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/icons/logo.svg',
                              ),
                              Opacity(
                                  opacity: 0,
                                  child: SvgPicture.asset(
                                      'assets/icons/notification.svg')),
                            ],
                          ),
                          SizedBox(
                            height: 41.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: 150.h,
                  //   left: 0,
                  //   right: 0,
                  //   child: Center(
                  //     // onTap: () async {
                  //     //   final file = await showBottom(context);
                  //     //   print("file===> $file");
                  //     //   if (file != null) {
                  //     //     setState(() {
                  //     //       selectedFile = File(file.path);
                  //     //     });
                  //     //   }
                  //     // },
                  //     child: ClipRRect(
                  //       borderRadius: BorderRadius.circular(100),
                  //       child: InkWell(
                  //         onTap: () async {
                  //           final file = await showBottom(context);
                  //           print("file===> $file");
                  //           if (file != null) {
                  //             setState(() {
                  //               selectedFile = File(file.path);
                  //             });
                  //           }
                  //         },
                  //         child: Container(
                  //           height: 120.h,
                  //           width: 120.h,
                  //           color: Colors.grey,
                  //           child: selectedFile != null
                  //               ? Image.file(
                  //                   selectedFile!,
                  //                   fit: BoxFit.fill,
                  //                 )
                  //               : const Icon(
                  //                   Icons.person,
                  //                   size: 50,
                  //                 ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                    top: 250.h,
                    left: 0,
                    right: 0,
                    child: Container(
                      // Wrap with Container
                      height: MediaQuery.of(context).size.height -
                          (181.h + 100.h), // Set a fixed height
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28.w),
                            child: Column(
                              children: [
                                CustomTextField(
                                  controller: _nameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "please enter name";
                                    }

                                    return null;
                                  },
                                  hintText: 'Name',
                                  label: 'Name',
                                ),
                                CustomTextField(
                                  readOnly: true,
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
                                Row(children: [
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
                                  // Expanded(
                                  //   child: CustomTextField(
                                  //     validator: (value) {
                                  //       if (value == null || value.isEmpty) {
                                  //         return "please enter GST No.";
                                  //       }
                                  //       return null;
                                  //     },
                                  //     controller: _gstController,
                                  //     hintText: '',
                                  //     label: 'GST No.',
                                  //     keyboardType: TextInputType.number,
                                  //   ),
                                  // ),
                                ]),
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
                                SizedBox(
                                  height: 20.h,
                                ),
                                SizedBox(
                                  height: 41.h,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: value.verifyCodeLoading
                                        ? null
                                        : () async {
                                            if (_formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              Map data = {
                                                'email': _emailController.text,
                                                'name': _nameController.text,
                                                'mobileNumber':
                                                    _mobileNumberController
                                                        .text,
                                                'address':
                                                    _addressController.text,
                                                'district':
                                                    _districtController.text,
                                                'pinCode':
                                                    _pincodeController.text,
                                                'state': _stateController.text,
                                                'gstNo': _gstController.text,
                                                'shopName':
                                                    _shopNameController.text,
                                              };
                                              if (selectedFile != null) {
                                                final res = await uploadImage(
                                                    selectedFile!);
                                                data.addAll(
                                                    {'profilePic': res});
                                              }
                                              value.upadateUserData(
                                                  data, context);
                                            }
                                          },
                                    child: value.verifyCodeLoading
                                        ? const CircularProgressIndicator(
                                            color: AppColor.white,
                                          )
                                        : const Text('Submit'),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          case Status.error:
            return Center(
              child: Text(value.userData.message.toString()),
            );
          default:
        }
        return Container();
      }),
    );
  }
}
