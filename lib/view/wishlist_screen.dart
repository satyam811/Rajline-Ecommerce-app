import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:raj_lines/data/response/status.dart';
import 'package:raj_lines/main_screen.dart';
import 'package:raj_lines/provider/cart_provider.dart';
// ignore: unused_import
import 'package:raj_lines/provider/productby_category_provider.dart';
import 'package:raj_lines/provider/wishlist_provider.dart';
import 'package:raj_lines/res/colors.dart';
import 'package:raj_lines/utils/utils.dart';
import 'package:raj_lines/view/product_details_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  Map<int, bool> itemLoadingState = {};
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<WishlistProvider>().fetchWishlistData();
    });
    super.initState();
  }

  bool isadded = false;
  @override
  Widget build(BuildContext context) {
    final addtoCartProvider = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        // leading: InkWell(
        //     onTap: () {
        //       Navigator.of(context).pop();
        //     },
        //     child: const Icon(Icons.arrow_back_ios_new_outlined)),
        centerTitle: true,
        title: const Text(
          'Your Wishlist',
          style: TextStyle(
              fontFamily: 'Poppins',
              color: AppColor.white,
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff12C1B1), Color(0xff0C68AD)])),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: SvgPicture.asset('assets/icons/notification.svg'))
        // ],
      ),
      body: Column(
        children: [
          Consumer<WishlistProvider>(builder: (context, value, child) {
            switch (value.wishlistData.status) {
              case Status.loading:
                return const Expanded(
                    child: Center(child: CircularProgressIndicator()));
              case Status.completed:
                return Expanded(
                    child: value.wishlistData.data!.wishlistProducts.isEmpty
                        ? const Center(
                            child:
                                Text('You\'ve not added products to Wishlist'),
                          )
                        : GridView.builder(
                            padding: EdgeInsets.only(
                                right: 12.w, left: 12.w, top: 17.h),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 22,
                                    mainAxisSpacing: 0,
                                    childAspectRatio: 150 / 285),
                            itemCount: value
                                .wishlistData.data!.wishlistProducts.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (value.wishlistData.data!
                                          .wishlistProducts[index].isDeleted) {
                                        return;
                                      }
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsScreen(
                                                title: value
                                                    .wishlistData
                                                    .data!
                                                    .wishlistProducts[index]
                                                    .name,
                                                id: value
                                                    .wishlistData
                                                    .data!
                                                    .wishlistProducts[index]
                                                    .id),
                                      ));
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 184.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  value
                                                      .wishlistData
                                                      .data!
                                                      .wishlistProducts[index]
                                                      .mainImage
                                                      .url,
                                                ),
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                        if (value.wishlistData.data!
                                            .wishlistProducts[index].isDeleted)
                                          Container(
                                            width: double.infinity,
                                            height: 184.h,
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
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor.white,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Text(
                                    value.wishlistData.data!
                                        .wishlistProducts[index].name,
                                    style: GoogleFonts.assistant(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff282C3F)),
                                  ),
                                  // Text(
                                  //   value.wishlistData.data!
                                  //       .wishlistProducts[index].description,
                                  //   maxLines: 2,
                                  //   overflow: TextOverflow.ellipsis,
                                  //   style: GoogleFonts.assistant(
                                  //       fontSize: 15,
                                  //       fontWeight: FontWeight.w400,
                                  //       color: const Color(0xff535766)),
                                  // ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    'Rs. ${value.wishlistData.data!.wishlistProducts[index].price}',
                                    style: GoogleFonts.assistant(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff282C3F)),
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [

                                  //     Text(
                                  //       'Rs. ${value.wishlistData.data!.wishlistProducts[index].price}',
                                  //       style: GoogleFonts.assistant(
                                  //           fontSize: 12,
                                  //           decoration: TextDecoration.lineThrough,
                                  //           fontWeight: FontWeight.w400,
                                  //           color: const Color(0xff7E818C)),
                                  //     ),
                                  //     Text(
                                  //       'Rs. (86% OFF)',
                                  //       style: GoogleFonts.assistant(
                                  //           fontSize: 12,
                                  //           fontWeight: FontWeight.w700,
                                  //           color: const Color(0xff0C68AD)),
                                  //     )
                                  //   ],
                                  // ),

                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  SizedBox(
                                      height: 30.h,
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        // onPressed: () {
                                        //   Navigator.of(context).push(MaterialPageRoute(
                                        //     builder: (context) => MainScreen(),
                                        //   ));
                                        // },
                                        onPressed: () async {
                                          int itemIndex = index;
                                          if (value
                                              .wishlistData
                                              .data!
                                              .wishlistProducts[index]
                                              .isDeleted) {
                                            Utils.toastMessage(
                                                'this product not available');
                                            return;
                                          }
                                          if (isadded && mounted) {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  const MainScreen(
                                                index: 2,
                                              ),
                                            ));
                                            return;
                                          }
                                          if (itemLoadingState[itemIndex] !=
                                              true) {
                                            Map data = {'quantity': 1};
                                            setState(() {
                                              itemLoadingState[itemIndex] =
                                                  true;
                                            });
                                            isadded = await addtoCartProvider
                                                .quntityUpdate(
                                                    data,
                                                    value
                                                        .wishlistData
                                                        .data!
                                                        .wishlistProducts[index]
                                                        .id,
                                                    context);
                                            setState(() {
                                              itemLoadingState[itemIndex] =
                                                  false;
                                            });
                                          }
                                        },

                                        child: itemLoadingState[index] ?? false
                                            ? const CircularProgressIndicator(
                                                color: AppColor.white,
                                              )
                                            : !isadded
                                                ? const Text(
                                                    'Add to bag',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                : const Text(
                                                    'Go to cart',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                      )),
                                  // InkWell(
                                  //   onTap: () async {
                                  //     if (isadded && mounted) {
                                  //       Navigator.of(context).push(MaterialPageRoute(
                                  //         builder: (context) => const MainScreen(
                                  //           index: 2,
                                  //         ),
                                  //       ));
                                  //       return;
                                  //     }
                                  //     Map data = {'quantity': 1};
                                  //     isadded = await addtoCartProvider.quntityUpdate(
                                  //         data,
                                  //         value.wishlistData.data!.wishlistProducts[index]
                                  //             .id,
                                  //         context);
                                  //   },
                                  //   child: Container(
                                  //     height: 30.h,
                                  //     alignment: Alignment.center,
                                  //     decoration: BoxDecoration(
                                  //         color: const Color(0xff0C68AD),
                                  //         borderRadius: BorderRadius.circular(5)),
                                  //     child: !isadded
                                  //         ? const Text(
                                  //             'Add to Cart',
                                  //             style: TextStyle(
                                  //                 fontSize: 11,
                                  //                 color: Colors.white,
                                  //                 fontFamily: 'Poppins',
                                  //                 fontWeight: FontWeight.w500),
                                  //           )
                                  //         : const Text(
                                  //             'Go to Cart',
                                  //             style: TextStyle(
                                  //                 fontSize: 11,
                                  //                 color: Colors.white,
                                  //                 fontFamily: 'Poppins',
                                  //                 fontWeight: FontWeight.w500),
                                  //           ),
                                  //   ),
                                  // ),
                                ],
                              );
                            },
                          ));
              case Status.error:
                return Center(
                  child: Text(value.wishlistData.message.toString()),
                );
              default:
            }
            return Container();
          }),
          SizedBox(
            height: 70.h,
          )
        ],
      ),
    );
  }
}
