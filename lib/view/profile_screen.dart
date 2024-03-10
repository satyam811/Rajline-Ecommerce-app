import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:raj_lines/data/response/status.dart';
import 'package:raj_lines/main_screen.dart';
import 'package:raj_lines/provider/profile_provider.dart';
import 'package:raj_lines/res/colors.dart';
import 'package:raj_lines/utils/shared_prefs.dart';
import 'package:raj_lines/view/auth/login_screen.dart';
import 'package:raj_lines/view/edit_profile_screen.dart';
import 'package:raj_lines/view/order_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _prefs = SharedPrefs.instance();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<ProfileProvider>().fetchUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProfileProvider>(builder: (context, value, child) {
        switch (value.userData.status) {
          case Status.loading:
            return const Center(child: CircularProgressIndicator());
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
                          // ),
                          Center(
                            child: SvgPicture.asset(
                              'assets/icons/logo.svg',
                            ),
                          ),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     // SvgPicture.asset(
                          //     //   'assets/icons/drawer.svg',
                          //     // SvgPicture.asset('assets/icons/notification.svg'),
                          //   ],
                          // ),
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
                  //   child: Container(
                  //     width: 147.w,
                  //     height: 147.h,
                  //     decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         color: const Color(0xFFe0f2f1),
                  //         image: DecorationImage(
                  //             image: NetworkImage(value
                  //                     .userData.data?.user.profilePic?.url ??
                  //                 'https://www.shutterstock.com/image-vector/man-icon-vector-260nw-1040084344.jpg'),
                  //             fit: BoxFit.fill)),
                  //   ),
                  // ),
                  Positioned(
                    top: 290.h,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const EditProfileScreen(),
                              ));
                            },
                            title: Text(
                              'Profile',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                  color: const Color(0xff31507F)),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Color(0xff31507F),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const OrderScreen(),
                              ));
                            },
                            title: Text(
                              'My Orders',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                  color: const Color(0xff31507F)),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Color(0xff31507F),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const MainScreen(
                                        index: 1,
                                      )));
                            },
                            title: Text(
                              'Wishlist',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                  color: const Color(0xff31507F)),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Color(0xff31507F),
                            ),
                          ),
                          // ListTile(
                          //   title: Text(
                          //     'Help',
                          //     style: GoogleFonts.inter(
                          //         fontWeight: FontWeight.w500,
                          //         fontSize: 22,
                          //         color: Color(0xff31507F)),
                          //   ),
                          //   trailing: Icon(
                          //     Icons.arrow_forward_ios,
                          //     size: 20,
                          //     color: Color(0xff31507F),
                          //   ),
                          // ),
                          ListTile(
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
                            title: Text(
                              'Logout',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                  color: const Color(0xff31507F)),
                            ),
                            trailing: const Icon(
                              Icons.logout,
                              size: 20,
                              color: Color(0xff31507F),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
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
