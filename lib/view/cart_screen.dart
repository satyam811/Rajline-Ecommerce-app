import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:raj_lines/data/response/status.dart';
import 'package:raj_lines/provider/cart_provider.dart';
import 'package:raj_lines/res/colors.dart';
import 'package:raj_lines/utils/utils.dart';
import 'package:raj_lines/view/payment_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<CartProvider>().fetchCartlistData();
    });
    super.initState();
  }

  int i = 1;
  int c = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CartProvider>(builder: (context, value, child) {
        switch (value.cartlistData.status) {
          case Status.loading:
            return const Center(child: CircularProgressIndicator());
          case Status.completed:
            return value.cartlistData.data!.items.isEmpty
                ? Center(
                    child: OutlinedButton(
                        onPressed: () {}, child: const Text('Cart is Empty')),
                  )
                : SizedBox(
                    height: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                          height: 181.h + 45.h,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Color(0xff12C1B1),
                            Color(0xff0C68AD)
                          ])),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 21.w, right: 21.w, top: 45.h),
                            child: Column(
                              children: [
                                Center(
                                  child: SvgPicture.asset(
                                    'assets/icons/logo.svg',
                                  ),
                                ),
                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     SvgPicture.asset(
                                //       'assets/icons/drawer.svg',
                                //     ),
                                //     SvgPicture.asset(
                                //         'assets/icons/notification.svg'),
                                //   ],
                                // ),
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
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      width: 2, color: Colors.grey.shade100)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 26.w, vertical: 25.h),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Subtotal',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          '₹ ${value.cartlistData.data!.subTotal}',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Tax',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          '₹ ${value.cartlistData.data!.tax.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Delivery',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          '₹ 0',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    const Divider(
                                      color: Colors.black, //color of divider
                                      height: 4, //height spacing of divider
                                      thickness: 2, //thickness of divier line
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Total',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '₹ ${value.cartlistData.data!.totalAmount}',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 390.h,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 21.w,
                            ),
                            child: Container(
                              padding: EdgeInsets.zero,
                              height: 260.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      width: 2, color: Colors.grey.shade100)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.w,
                                ),
                                child: ListView.builder(
                                  padding: EdgeInsets.symmetric(vertical: 21.h),
                                  itemCount:
                                      value.cartlistData.data!.items.length,
                                  itemBuilder: (context, index) {
                                    int count = value.cartlistData.data!
                                        .items[index].quantity;

                                    c = value.cartlistData.data!.items[index]
                                        .quantity;

                                    return Container(
                                      margin: EdgeInsets.only(bottom: 7.h),
                                      height: 67.h,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 65.h,
                                            child: Image.network(
                                              value
                                                  .cartlistData
                                                  .data!
                                                  .items[index]
                                                  .productId
                                                  .mainImage
                                                  .url,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                value
                                                    .cartlistData
                                                    .data!
                                                    .items[index]
                                                    .productId
                                                    .name,
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'x $count',
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    width: 100.w,
                                                  ),
                                                  Row(
                                                    // crossAxisAlignment:
                                                    //     CrossAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          if (count == 1) {
                                                            log('delete');
                                                            value.deleteFromcart(
                                                                value
                                                                    .cartlistData
                                                                    .data!
                                                                    .items[
                                                                        index]
                                                                    .productId
                                                                    .id,
                                                                context);
                                                            return;
                                                          }
                                                          setState(() {
                                                            c = count - i;
                                                          });
                                                          Map data = {
                                                            'quantity': c
                                                          };
                                                          value.quntityUpdate(
                                                              data,
                                                              value
                                                                  .cartlistData
                                                                  .data!
                                                                  .items[index]
                                                                  .productId
                                                                  .id,
                                                              context);
                                                        },
                                                        child: Container(
                                                            width: 20,
                                                            height: 20,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: const BoxDecoration(
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            3),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            3)),
                                                                color: Color(
                                                                    0xff0C68AD)),
                                                            child: count == 1
                                                                ? Icon(
                                                                    Icons
                                                                        .delete,
                                                                    size: 13.h,
                                                                    color: AppColor
                                                                        .white,
                                                                  )
                                                                : const Text(
                                                                    '-',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  )),
                                                      ),
                                                      Container(
                                                        width: 20,
                                                        height: 20,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: Color(
                                                                    0xffCBE9FF)),
                                                        child: Text('$c'),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          if (c >=
                                                              value
                                                                  .cartlistData
                                                                  .data!
                                                                  .items[index]
                                                                  .productId
                                                                  .stock) {
                                                            Utils.toastMessage(
                                                                'out of stock');
                                                            return;
                                                          }
                                                          setState(() {
                                                            c = count + i;
                                                          });
                                                          Map data = {
                                                            'quantity': c
                                                          };
                                                          value.quntityUpdate(
                                                              data,
                                                              value
                                                                  .cartlistData
                                                                  .data!
                                                                  .items[index]
                                                                  .productId
                                                                  .id,
                                                              context);
                                                        },
                                                        child: Container(
                                                            width: 20,
                                                            height: 20,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: const BoxDecoration(
                                                                borderRadius: BorderRadius.only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            3),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            3)),
                                                                color: Color(
                                                                    0xff0C68AD)),
                                                            child: const Text(
                                                              '+',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                '${value.cartlistData.data!.items[index].productId.price}/-',
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 11,
                                                    color: Color(0xff0D6AAE),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                // child: Column(
                                //   children: [
                                //     for (int i = 0; i < 3; i++)
                                //       Padding(
                                //         padding: const EdgeInsets.only(bottom: 4.0),
                                //         child: Container(
                                //           height: 67.h,
                                //           child: Row(
                                //             crossAxisAlignment: CrossAxisAlignment.start,
                                //             children: [
                                //               Image.asset(
                                //                 'assets/icons/Rectangle 5.png',
                                //               ),
                                //               SizedBox(
                                //                 width: 10.w,
                                //               ),
                                //               const Column(
                                //                 crossAxisAlignment:
                                //                     CrossAxisAlignment.start,
                                //                 mainAxisAlignment:
                                //                     MainAxisAlignment.spaceEvenly,
                                //                 children: [
                                //                   Text(
                                //                     'Polycab wires',
                                //                     style: TextStyle(
                                //                         fontFamily: 'Poppins',
                                //                         fontSize: 11,
                                //                         fontWeight: FontWeight.w500),
                                //                   ),
                                //                   Text(
                                //                     'x 1',
                                //                     style: TextStyle(
                                //                         fontFamily: 'Poppins',
                                //                         fontSize: 11,
                                //                         fontWeight: FontWeight.w500),
                                //                   ),
                                //                   Text(
                                //                     '799/-',
                                //                     style: TextStyle(
                                //                         fontFamily: 'Poppins',
                                //                         fontSize: 11,
                                //                         color: Color(0xff0D6AAE),
                                //                         fontWeight: FontWeight.w500),
                                //                   )
                                //                 ],
                                //               ),
                                //               const Spacer(),
                                //               Center(
                                //                 child: Row(
                                //                   mainAxisAlignment:
                                //                       MainAxisAlignment.center,
                                //                   crossAxisAlignment:
                                //                       CrossAxisAlignment.center,
                                //                   children: [
                                //                     Container(
                                //                         width: 20,
                                //                         height: 20,
                                //                         alignment: Alignment.center,
                                //                         decoration: const BoxDecoration(
                                //                             borderRadius: BorderRadius.only(
                                //                                 topLeft: Radius.circular(3),
                                //                                 bottomLeft:
                                //                                     Radius.circular(3)),
                                //                             color: Color(0xff0C68AD)),
                                //                         child: const Text(
                                //                           '-',
                                //                           style: TextStyle(
                                //                               color: Colors.white),
                                //                         )),
                                //                     Container(
                                //                       width: 20,
                                //                       height: 20,
                                //                       alignment: Alignment.center,
                                //                       decoration: const BoxDecoration(
                                //                           color: Color(0xffCBE9FF)),
                                //                       child: const Text('1'),
                                //                     ),
                                //                     InkWell(
                                //                       child: Container(
                                //                           width: 20,
                                //                           height: 20,
                                //                           alignment: Alignment.center,
                                //                           decoration: const BoxDecoration(
                                //                               borderRadius:
                                //                                   BorderRadius.only(
                                //                                       topRight: Radius
                                //                                           .circular(3),
                                //                                       bottomRight:
                                //                                           Radius.circular(
                                //                                               3)),
                                //                               color: Color(0xff0C68AD)),
                                //                           child: const Text(
                                //                             '+',
                                //                             style: TextStyle(
                                //                                 color: Colors.white),
                                //                           )),
                                //                     ),
                                //                   ],
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //         ),

                                //       ),
                                //     SizedBox(
                                //       height: 5.h,
                                //     )
                                //   ],
                                // ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 75,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 21.w),
                            child: ElevatedButton(
                                onPressed: () async {
                                  await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) => PaymentScreen(
                                        totalAmount: value
                                            .cartlistData.data!.totalAmount),
                                  ));
                                  context
                                      .read<CartProvider>()
                                      .fetchCartlistData();
                                },
                                style: ButtonStyle(
                                    fixedSize: MaterialStatePropertyAll(
                                        Size(319.w, 44.h)),
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                            Color(0xff0C68AD)),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)))),
                                child: const Text(
                                  'Checkout',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700),
                                )),
                          ),
                        ),
                        if (value.updateLoading)
                          const Opacity(
                            opacity: 0.3,
                            child: ModalBarrier(
                                dismissible: false, color: Colors.black),
                          ),
                        if (value.updateLoading)
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                      ],
                    ),
                  );
          case Status.error:
            return Center(
              child: Text(value.cartlistData.message.toString()),
            );
          default:
        }
        return Container();
      }),
    );
  }
}
