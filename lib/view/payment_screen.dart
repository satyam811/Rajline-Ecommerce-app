import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:raj_lines/data/response/status.dart';
import 'package:raj_lines/provider/cart_provider.dart';
import 'package:raj_lines/provider/payment_provider.dart';
import 'package:raj_lines/provider/profile_provider.dart';
import 'package:raj_lines/view/order_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.totalAmount});
  final double totalAmount;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isPay = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<ProfileProvider>().fetchUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentProvider>(context);

    return Scaffold(
      body: Consumer<ProfileProvider>(builder: (context, value, child) {
        switch (value.userData.status) {
          case Status.loading:
            return Center(child: CircularProgressIndicator());
          case Status.completed:
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
                  Positioned(
                    top: 175.h,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 21.w),
                      child: Container(
                        height: 510.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                width: 2, color: Colors.grey.shade100)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.w, vertical: 14.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Payment',
                                style: GoogleFonts.inter(
                                    color: const Color(0xff303437),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                              SizedBox(height: 15.h),
                              Row(
                                children: [
                                  Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF2F4F5),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  SizedBox(
                                    width: 13.w,
                                  ),
                                  Text(
                                    'Cash On Delivery',
                                    style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xff404446)),
                                  ),
                                  const Spacer(),
                                  Radio(
                                    value: 0,
                                    groupValue: 0,
                                    onChanged: (value) => 0,
                                    activeColor: const Color(0xff404446),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 22.h,
                              ),
                              const Divider(
                                color: Color(0xffD0D0D0), //color of divider
                                height: 1, //height spacing of divider
                                thickness: 2, //thickness of divier line
                              ),
                              SizedBox(
                                height: 17.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Shipping Information',
                                    style: GoogleFonts.inter(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xff303437)),
                                  ),
                                  Text(
                                    'Edit',
                                    style: GoogleFonts.inter(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xff303437)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                  value
                                      .userData.data!.user.address.addressLine1,
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff979C9E),
                                  )),
                              Text(
                                  '${value.userData.data!.user.address.city}, ${value.userData.data!.user.address.state}',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff979C9E),
                                  )),
                              Text(value.userData.data!.user.address.pincode,
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff979C9E),
                                  )),
                              Text(value.userData.data!.user.mobileNumber,
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff979C9E),
                                  )),
                              SizedBox(
                                height: 22.h,
                              ),
                              const Divider(
                                color: Color(0xffD0D0D0), //color of divider
                                height: 1, //height spacing of divider
                                thickness: 2, //thickness of divier line
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xff000000),
                                        fontSize: 20,
                                      )),
                                  Text('${widget.totalAmount}',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xff000000),
                                        fontSize: 20,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 25.h,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 21.w),
                      child: ElevatedButton(
                          onPressed: paymentProvider.paymentLoading
                              ? () {}
                              : () async {
                                  if (isPay && mounted) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => OrderScreen(),
                                    ));
                                    return;
                                  }
                                  Map data = {};
                                  isPay = await paymentProvider.paymentOrder(
                                      data, context);
                                },
                          style: ButtonStyle(
                              fixedSize:
                                  MaterialStatePropertyAll(Size(319.w, 44.h)),
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xff0C68AD)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12)))),
                          child: paymentProvider.paymentLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : !isPay
                                  ? const Text(
                                      'Pay',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700),
                                    )
                                  : const Text(
                                      'Go to Order',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700),
                                    )),
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
