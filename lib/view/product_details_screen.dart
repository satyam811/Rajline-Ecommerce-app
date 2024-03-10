import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:raj_lines/data/response/status.dart';
import 'package:raj_lines/main_screen.dart';
import 'package:raj_lines/provider/cart_provider.dart';
import 'package:raj_lines/provider/details_provider.dart';
import 'package:raj_lines/res/colors.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.title,
    required this.id,
  });
  final String title;
  final String id;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  List imageList = [
    {"id": 1, 'imagePath': 'assets/dumy/cilingFan.png'},
    {"id": 1, 'imagePath': 'assets/dumy/cilingFan.png'},
    {"id": 1, 'imagePath': 'assets/dumy/cilingFan.png'},
  ];
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<ProductDetailsProvider>().fetchProductDetailsData(widget.id);
    });
    super.initState();
  }

  int i = 1;
  int _tabIndex = 0;

  int currentIndex = 0;
  bool isadded = false;
  bool isFav = false;
  final CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    final detailsProvider = context.watch<ProductDetailsProvider>();
    final addtoCartProvider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back_ios_new_outlined)),
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
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
        // actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          height: 70.h,
          child: Row(
            children: [
              InkWell(
                onTap: () async {
                  setState(() {
                    isFav = !isFav;
                  });

                  Map data = {
                    'productId': detailsProvider.poductDetails.data!.product.id
                  };
                  await detailsProvider.favroiteAndUnfavroiteApi(data, context);
                  setState(() {});
                },
                child: Consumer<ProductDetailsProvider>(
                    builder: (context, value, child) {
                  return Container(
                      height: 40.h,
                      width: 40.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: const Color(0xffAAAAAA),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/wishlist.svg',
                        color: (isFav ||
                                (value.poductDetails.data?.isFavourite ??
                                    false))
                            ? Colors.red
                            : null,
                      ));
                }),
              ),
              SizedBox(
                width: 12.w,
              ),
              Expanded(
                child: SizedBox(
                    height: 41.h,
                    child: ElevatedButton(
                      // onPressed: () {
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => MainScreen(),
                      //   ));
                      // },
                      onPressed: () async {
                        if (isadded && mounted) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MainScreen(
                              index: 2,
                            ),
                          ));
                          return;
                        }
                        Map data = {'quantity': i};
                        isadded = await addtoCartProvider.quntityUpdate(
                            data,
                            detailsProvider.poductDetails.data!.product.id,
                            context);

                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => MainScreen(
                        //     index: 2,
                        //   ),
                        // ));
                      },
                      child: addtoCartProvider.updateLoading
                          ? CircularProgressIndicator(
                              color: AppColor.white,
                            )
                          : !isadded
                              ? const Text(
                                  'Add to bag',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                )
                              : const Text(
                                  'Go to cart',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                ),
                    )),
              ),
              // Expanded(
              //   child: InkWell(
              //     onTap: () async {
              //       if (isadded && mounted) {
              //         Navigator.of(context).push(MaterialPageRoute(
              //           builder: (context) => const MainScreen(
              //             index: 2,
              //           ),
              //         ));
              //         return;
              //       }
              //       Map data = {'quantity': i};
              //       isadded = await addtoCartProvider.quntityUpdate(
              //           data,
              //           detailsProvider.poductDetails.data!.product.id,
              //           context);

              //       // Navigator.of(context).push(MaterialPageRoute(
              //       //   builder: (context) => MainScreen(
              //       //     index: 2,
              //       //   ),
              //       // ));
              //     },

              //     child: Container(
              //       height: 40,
              //       alignment: Alignment.center,
              //       decoration: BoxDecoration(
              //           color: const Color(0xff0C68AD),
              //           borderRadius: BorderRadius.circular(8)),
              //       child: !isadded
              //           ? const Text(
              //               'Add to bag',
              //               style: TextStyle(
              //                   fontSize: 14,
              //                   color: Colors.white,
              //                   fontFamily: 'Poppins',
              //                   fontWeight: FontWeight.w600),
              //             )
              //           : const Text(
              //               'Go to cart',
              //               style: TextStyle(
              //                   fontSize: 14,
              //                   color: Colors.white,
              //                   fontFamily: 'Poppins',
              //                   fontWeight: FontWeight.w600),
              //             ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
      body: Consumer<ProductDetailsProvider>(builder: (context, value, child) {
        switch (value.poductDetails.status) {
          case Status.loading:
            return const Center(child: CircularProgressIndicator());
          case Status.completed:
            return SizedBox(
              height: double.infinity,
              child: Stack(
                children: [
                  SizedBox(
                    height: 300.h,
                    child: CarouselSlider(
                      items: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Stack(
                            children: [
                              Center(
                                child: Image.network(
                                  value.poductDetails.data!.product.mainImage
                                      .url,
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...value.poductDetails.data!.product.subImages
                            .map(
                              (item) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Image.network(
                                        item.url,
                                        fit: BoxFit.fill,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ],
                      carouselController: carouselController,
                      options: CarouselOptions(
                        height: double.infinity,
                        scrollPhysics: const BouncingScrollPhysics(),
                        aspectRatio: MediaQuery.of(context).size.width /
                            MediaQuery.of(context).size.height,
                        viewportFraction: 1,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          if (kDebugMode) {
                            print("index => $index");
                          }
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 240,
                    left: 0.0,
                    right: 0.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...value.poductDetails.data!.product.subImages
                            .asMap()
                            .entries
                            .map((entry) {
                          final int index = entry.key;
                          final bool isCurrentIndex = currentIndex == index;

                          return Container(
                            width: 10.w,
                            height: 10.h,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isCurrentIndex
                                  ? const Color(0xff0D6EAE)
                                  : const Color(0xffD9D9D9),
                            ),
                          );
                        }).toList(),
                        Container(
                          // Add one more indicator circle
                          width: 10.w,
                          height: 10.h,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentIndex ==
                                    value.poductDetails.data!.product.subImages
                                        .length
                                ? const Color(
                                    0xff0D6EAE) // Use the desired color for the additional indicator
                                : const Color(0xffD9D9D9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 270,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 500,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 31.h, left: 21.w, right: 21.w),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                value.poductDetails.data!.product.name,
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    color: const Color(0xff121212)),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Rs. ${value.poductDetails.data!.product.price}',
                                    style: GoogleFonts.assistant(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff282C3F)),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (i > 1) {
                                              i--;
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0xff0C68AD)),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: const Text(
                                            '-',
                                            style: TextStyle(
                                              color: Color(0xff0C68AD),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7.w,
                                      ),
                                      Text('$i'),
                                      SizedBox(
                                        width: 7.w,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          log('message');
                                          setState(() {
                                            if (i <
                                                value.poductDetails.data!
                                                    .product.stock) {
                                              i++;
                                            }
                                          });
                                          setState(() {});
                                        },
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0xff0C68AD)),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: const Text(
                                            '+',
                                            style: TextStyle(
                                              color: Color(0xff0C68AD),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 27.h,
                              ),
                              // Container(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 10),
                              //   height: 69.h,
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //       color: const Color(0xffFAFAFA),
                              //       borderRadius: BorderRadius.circular(8)),
                              //   child: Row(
                              //     children: [
                              //       Center(
                              //         child: Column(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.center,
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           children: [
                              //             Row(
                              //               mainAxisSize: MainAxisSize.min,
                              //               children: [
                              //                 RatingBar.builder(
                              //                   initialRating: 4,
                              //                   minRating: 1,
                              //                   direction: Axis.horizontal,
                              //                   allowHalfRating: true,
                              //                   itemSize: 20.0,
                              //                   itemCount: 5,
                              //                   itemPadding:
                              //                       const EdgeInsets.symmetric(
                              //                           horizontal: 0),
                              //                   itemBuilder: (context, _) =>
                              //                       const Icon(
                              //                     Icons.star,
                              //                     color: Colors.amber,
                              //                   ),
                              //                   onRatingUpdate: (rating) {
                              //                     if (kDebugMode) {
                              //                       print(rating);
                              //                     }
                              //                   },
                              //                 ),
                              //                 const Text('4.6')
                              //               ],
                              //             ),
                              //             Text(
                              //               '98 Reviews >',
                              //               style: GoogleFonts.poppins(
                              //                   fontSize: 12,
                              //                   color: const Color(0xffAAAAAA)),
                              //             )
                              //           ],
                              //         ),
                              //       ),
                              //       const Spacer(),
                              //       Image.asset('assets/dumy/Avatars.png')
                              //     ],
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 27.h,
                              // ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _tabIndex = 0;
                                      });
                                    },
                                    child: Container(
                                      height: 37.h,
                                      width: 106.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _tabIndex == 0
                                            ? const Color(0xffDFF2FF)
                                            : null,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        'Description',
                                        style: GoogleFonts.poppins(
                                            color: _tabIndex == 0
                                                ? const Color(0xff0C68AD)
                                                : const Color(0xffAAAAAA),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _tabIndex = 1;
                                      });
                                    },
                                    child: Container(
                                      height: 37.h,
                                      width: 106.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _tabIndex == 1
                                            ? const Color(0xffDFF2FF)
                                            : null,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        'Materials',
                                        style: GoogleFonts.poppins(
                                            color: _tabIndex == 1
                                                ? const Color(0xff0C68AD)
                                                : const Color(0xffAAAAAA),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 17.h,
                              ),
                              Text(
                                _tabIndex == 0
                                    ? value
                                        .poductDetails.data!.product.description
                                    : value
                                        .poductDetails.data!.product.material,
                                style: GoogleFonts.poppins(
                                    color: const Color(0xffAAAAAA),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 200.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          case Status.error:
            return Center(
              child: Text(value.poductDetails.message.toString()),
            );
          default:
        }
        return Container();
      }),
    );
  }
}
