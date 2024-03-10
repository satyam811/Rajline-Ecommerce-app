import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:raj_lines/data/response/status.dart';
import 'package:raj_lines/main_screen.dart';
import 'package:raj_lines/provider/home_provider.dart';
import 'package:raj_lines/utils/shared_prefs.dart';
import 'package:raj_lines/view/auth/login_screen.dart';
import 'package:raj_lines/view/categories_screen.dart';
import 'package:raj_lines/view/main_category_search.dart';
import 'package:raj_lines/view/notification_screen.dart';
import 'package:raj_lines/view/order_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _prefs = SharedPrefs.instance();

  List imageList = [
    {"id": 1, 'imagePath': 'assets/icons/Link.png'},
    {"id": 2, 'imagePath': 'assets/icons/Link.png'},
    {"id": 3, 'imagePath': 'assets/icons/Link.png'},
    {"id": 4, 'imagePath': 'assets/icons/Link.png'},
    {"id": 5, 'imagePath': 'assets/icons/Link.png'},
    {"id": 6, 'imagePath': 'assets/icons/Link.png'},
  ];

  List imageList1 = [
    {"id": 1, 'imagePath': 'assets/dumy/pic 2@4x.png'},
    {"id": 2, 'imagePath': 'assets/dumy/pic 7@4x.png'},
    {"id": 3, 'imagePath': 'assets/dumy/pic 4@4x.png'},
    {"id": 4, 'imagePath': 'assets/dumy/pic1@4x.png'},
    {"id": 5, 'imagePath': 'assets/dumy/pic 2@4x.png'},
    {"id": 6, 'imagePath': 'assets/dumy/pic1@4x.png'},
  ];

  List imageList2 = [
    {
      "id": 1,
      'imagePath': 'assets/dumy/pic 2@4x.png',
      'title': 'Floor Fans',
      'price': 'Starting from 1499 ₹'
    },
    {
      "id": 2,
      'imagePath': 'assets/dumy/pic 7@4x.png',
      'title': ' Spot Lights',
      'price': 'Starting from 499 ₹'
    },
    {
      "id": 3,
      'imagePath': 'assets/dumy/pic 4@4x.png',
      'title': 'Tower Fans',
      'price': 'Starting from 799 ₹'
    },
    {
      "id": 4,
      'imagePath': 'assets/dumy/pic1@4x.png',
      'title': 'Heat Convector',
      'price': 'Starting from 1499 ₹'
    },
    {
      "id": 5,
      'imagePath': 'assets/dumy/pic1@4x.png',
      'title': 'Heat Convector',
      'price': 'Starting from 89 ₹'
    },
    {
      "id": 6,
      'imagePath': 'assets/dumy/pic 7@4x.png',
      'title': ' Spot Lights',
      'price': 'Starting from 149 ₹'
    },
  ];

  bool isLoading = true;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<HomeProvider>().fetchHomeData();
      context.read<HomeProvider>().fetchBannerData();
    });
    super.initState();
  }

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
          // Define your drawer content here.
          child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff12C1B1), Color(0xff0C68AD)])),
            accountName: Text(_prefs.name),
            accountEmail: Text(_prefs.email ?? ''),
            currentAccountPicture: SvgPicture.asset(
              'assets/icons/logo.svg',
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.badge),
          //   title: const Text('My order'),
          //   onTap: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //       builder: (context) => const OrderScreen(),
          //     ));
          //   },
          // ),
          ListTile(
            leading: SvgPicture.asset('assets/icons/home.svg'),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/icons/favourite.svg'),
            title: const Text('Favroite'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MainScreen(
                  index: 1,
                ),
              ));
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/icons/badge.svg'),
            title: const Text('Cart'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const MainScreen(
                  index: 2,
                ),
              ));
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/icons/persion.svg'),
            title: const Text('Profile'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MainScreen(
                  index: 3,
                ),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.badge),
            title: const Text('My order'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const OrderScreen(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              await _prefs.clear();
              _prefs.removeToken('token');
              if (!mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false);
            },
          )
        ],
      )),
      body: RefreshIndicator(
        onRefresh: () => Future.wait([
          homeProvider.fetchHomeData(),
          context.read<HomeProvider>().fetchBannerData()
        ]),
        child: SingleChildScrollView(
          child: Column(
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
                        children: [
                          InkWell(
                            onTap: () {
                              _scaffoldKey.currentState!.openDrawer();
                            },
                            child: SvgPicture.asset(
                              'assets/icons/drawer.svg',
                            ),
                          ),
                          Spacer(),
                          SvgPicture.asset(
                            'assets/icons/logo.svg',
                          ),
                          Spacer(),
                          Opacity(
                            opacity: 0,
                            child: SvgPicture.asset(
                              'assets/icons/drawer.svg',
                            ),
                          ),
                          // InkWell(
                          //     onTap: () {
                          //       Navigator.of(context).push(MaterialPageRoute(
                          //         builder: (context) =>
                          //             const NotificationScreen(),
                          //       ));
                          //     },
                          //     child: SvgPicture.asset(
                          //         'assets/icons/notification.svg')),
                        ],
                      ),
                      SizedBox(
                        height: 41.h,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        readOnly: true,
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainCategorySearch(),
                            )),
                        decoration: InputDecoration(
                          hintText: 'What are you looking for ?',
                          hintStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: Color(0xff12c1b1),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              'assets/icons/search.svg',
                              height: 20,
                              width: 20,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(55),
                            borderSide: const BorderSide(
                              width: 1,
                              style: BorderStyle.none,
                              color: Color(0xff12c1b1),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(55),
                            borderSide: const BorderSide(
                              width: 1,
                              style: BorderStyle.none,
                              color: Color(0xff12c1b1),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(55),
                            borderSide: const BorderSide(
                              width: 1,
                              style: BorderStyle.none,
                              color: Color(0xff12c1b1),
                            ),
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.all(16),
                          fillColor: const Color(0xfff2fffe),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<HomeProvider>(builder: (context, value, child) {
                switch (value.homeData.status) {
                  case Status.loading:
                    return const CircularProgressIndicator();
                  case Status.completed:
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: CarouselSlider(
                            items: value.bannerData.data
                                ?.map(
                                  (item) => Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 8.h),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: Image.network(
                                              item.image.url,
                                              fit: BoxFit.fill,
                                              width: double.infinity,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            carouselController: carouselController,
                            options: CarouselOptions(
                              scrollPhysics: const BouncingScrollPhysics(),
                              aspectRatio: 2,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0;
                                i < (value.bannerData.data?.length ?? 0);
                                i++)
                              Container(
                                width: 10.w,
                                height: 10.h,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentIndex == i
                                      ? const Color(0xff0D6EAE)
                                      : const Color(0xffD9D9D9),
                                ),
                              )
                          ],
                        ),
                        SizedBox(
                          height: 17.h,
                        ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 12.w),
                        //   child: const Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(
                        //         'Shop by Categories',
                        //         style: TextStyle(
                        //             fontFamily: 'Poppins',
                        //             color: Color(0xff0D6AAE),
                        //             fontSize: 16,
                        //             fontWeight: FontWeight.w600),
                        //       ),
                        //       Text(
                        //         'See all',
                        //         style: TextStyle(
                        //             fontFamily: 'Poppins',
                        //             color: Color(0xffACACAC),
                        //             fontSize: 13,
                        //             fontWeight: FontWeight.w600),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 14.h,
                        // ),
                        // SizedBox(
                        //   height: 70.h,
                        //   child: ListView.builder(
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: imageList1.length,
                        //       itemBuilder: (context, index) => InkWell(
                        //             // onTap: () {
                        //             //   Navigator.of(context)
                        //             //       .push(MaterialPageRoute(
                        //             //     builder: (context) => CategoriesScreen(),
                        //             //   ));
                        //             // },
                        //             child: Container(
                        //               margin: const EdgeInsets.only(
                        //                   left: 17, top: 5, bottom: 5),
                        //               height: 60.h,
                        //               width: 60.h,
                        //               decoration: BoxDecoration(
                        //                   color: const Color(0xffF4F4F4),
                        //                   shape: BoxShape.circle,
                        //                   boxShadow: [
                        //                     BoxShadow(
                        //                         offset: const Offset(0, 0),
                        //                         color: Colors.black
                        //                             .withOpacity(0.25),
                        //                         // spreadRadius: 15,
                        //                         blurRadius: 4)
                        //                   ]),
                        //               child: Padding(
                        //                 padding: const EdgeInsets.all(8.0),
                        //                 child: Image.asset(
                        //                   imageList1[index]['imagePath'],
                        //                 ),
                        //               ),
                        //             ),
                        //           )),
                        // ),
                        // SizedBox(
                        //   height: 20.h,
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Shop by Categories',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xff0D6AAE),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'See all',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xffACACAC),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 10.h),
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 153 / 211),
                            itemCount:
                                value.homeData.data?.mainCategories.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CategoriesScreen(
                                      id: value.homeData.data!
                                          .mainCategories[index].id,
                                      type: value.homeData.data!
                                          .mainCategories[index].name,
                                    ),
                                  ));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 9.h, left: 13.w, right: 13.w),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF4F4F4),
                                    borderRadius: BorderRadius.circular(17),
                                  ),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Container(
                                      //   height: 141.h,
                                      //   width: double.infinity,
                                      //   decoration: BoxDecoration(
                                      //     color: Colors.white,
                                      //     borderRadius: BorderRadius.circular(12),
                                      //   ),
                                      //   child: Image.asset(
                                      //     imageList2[index]['imagePath'],
                                      //     fit: BoxFit.fill,
                                      //   ),
                                      // ),
                                      Container(
                                        width: double.infinity,
                                        height: 141.h,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                value
                                                    .homeData
                                                    .data!
                                                    .mainCategories[index]
                                                    .imageUrl
                                                    .url,
                                              ),
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text(
                                        value.homeData.data!
                                            .mainCategories[index].name,
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 10),
                                      ),
                                      Text(
                                        'Starting from ${value.homeData.data!.mainCategories[index].startingPrice} ₹',
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 70.h,
                        )
                      ],
                    );
                  case Status.error:
                    return Center(
                      child: Text(value.homeData.message.toString()),
                    );
                  default:
                }
                return Container();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
