import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:raj_lines/data/response/status.dart';
import 'package:raj_lines/provider/order_provider.dart';
import 'package:raj_lines/res/colors.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<OrderProvider>().fetchOrderData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 181.h + 45.h,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff12C1B1), Color(0xff0C68AD)])),
            child: Padding(
              padding: EdgeInsets.only(left: 21.w, right: 21.w, top: 45.h),
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
                    height: 60.h,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'MY ORDERS',
                      style: GoogleFonts.poppins(
                        color: AppColor.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Consumer<OrderProvider>(
            builder: (context, value, child) {
              switch (value.orderData.status) {
                case Status.loading:
                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));

                case Status.completed:
                  return Expanded(
                    child: value.orderData.data!.orders.isEmpty
                        ? const Center(child: Text('Orders not found'))
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 11.w),
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              itemCount: value.orderData.data!.orders.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Container(
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        // Padding(
                                        //   padding: EdgeInsets.symmetric(
                                        //       horizontal: 28.w),
                                        //   child: Row(
                                        //     children: [
                                        //       SvgPicture.asset(
                                        //           'assets/icons/Frame.svg'),
                                        //       // Text(
                                        //       //   'Delivered on 16.07.2022, 20:53',
                                        //       //   style: GoogleFonts.poppins(
                                        //       //       fontWeight: FontWeight.w400,
                                        //       //       fontSize: 10,
                                        //       //       color: const Color(
                                        //       //           0xff0c68AD)),
                                        //       // )
                                        //     ],
                                        //   ),
                                        // ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 28.w),
                                          child: Text(
                                            value.orderData.data!.orders[index]
                                                .id,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                                color: const Color(0xff0c68AD)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        const Divider(
                                          color: Color(
                                              0xffDBDBDB), //color of divider
                                          height:
                                              0.5, //height spacing of divider
                                          thickness:
                                              1, //thickness of divier line
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          itemCount: value.orderData.data!
                                              .orders[index].items.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, i) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 7.h),
                                              child: SizedBox(
                                                height: 60.h,
                                                width: double.infinity,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 28.w),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Image.network(
                                                            value
                                                                .orderData
                                                                .data!
                                                                .orders[index]
                                                                .items[i]
                                                                .productId
                                                                .mainImage
                                                                .url,
                                                            width: 58.w,
                                                            fit: BoxFit.fill,
                                                            height: 58.w,
                                                          ),
                                                          if(value.orderData.data!
                                                              .orders[index].items[i].productId.isDeleted)
                                                          Container(
                                                            width: 58.w,
                                                            height: 58.w,
                                                            alignment: Alignment.center,
                                                            decoration: BoxDecoration(
                                                              color:
                                                              Colors.black.withOpacity(0.7),
                                                              borderRadius:
                                                              BorderRadius.circular(8),
                                                            ),
                                                            child: const Text(
                                                              'Product\ndeleted..',
                                                              style: TextStyle(

                                                                fontSize: 10,
                                                                fontWeight: FontWeight.w700,
                                                                color: AppColor.white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],



                                                      ),
                                                      SizedBox(
                                                        width: 16.w,
                                                      ),
                                                      Expanded(
                                                        // Use Expanded to allow this column to take available space
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              value
                                                                  .orderData
                                                                  .data!
                                                                  .orders[index]
                                                                  .items[i]
                                                                  .productId
                                                                  .name,
                                                              // overflow:
                                                              //     TextOverflow
                                                              //         .ellipsis,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: const Color(
                                                                    0xff0C68AD),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  '${value.orderData.data!.orders[index].items[i].quantity}pc',
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    color: const Color(
                                                                        0xff85939B),
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 150.w,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomRight,
                                                                  child: Text(
                                                                    '${value.orderData.data!.orders[index].items[i].productId.price}',
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      color: const Color(
                                                                          0xff0C68AD),
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),

                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 28.w),
                                          child: const Divider(
                                            color: Color(
                                                0xffDBDBDB), //color of divider
                                            height:
                                                0.5, //height spacing of divider
                                            thickness:
                                                1, //thickness of divier line
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 28.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    value.orderData.data!
                                                        .orders[index].items
                                                        .fold(
                                                            0,
                                                            (previousValue,
                                                                    element) =>
                                                                previousValue +
                                                                element
                                                                    .quantity)
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 10,
                                                        color: const Color(
                                                            0xffE64B32)),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const VerticalDivider(
                                                    color: Color(
                                                        0xffDBDBDB), //color of divider

                                                    thickness:
                                                        2, //thickness of divier line
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    '${value.orderData.data!.orders[index].totalAmountWithTax}',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 10,
                                                        color: const Color(
                                                            0xffE64B32)),
                                                  )
                                                ],
                                              ),
                                              const Icon(
                                                Icons.arrow_forward_ios,
                                                color: Color(0xffE64B32),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  );
                case Status.error:
                  return Center(
                    child: Text(value.orderData.message.toString()),
                  );
                default:
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
