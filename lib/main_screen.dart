import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:raj_lines/view/cart_screen.dart';
import 'package:raj_lines/view/home_screen.dart';
import 'package:raj_lines/view/profile_screen.dart';
import 'package:raj_lines/view/wishlist_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.index = 0});
  final int index;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const WishlistScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        ),
        child: Card(
          elevation: 1,
          margin: EdgeInsets.zero,
          child: BottomAppBar(
            color: Colors.white,
            height: 64.h,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BottomNavItem(
                    selectedIcon: 'assets/icons/homeFill.svg',
                    unselectedIcon: 'assets/icons/home.svg',
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                    isSelected: _selectedIndex == 0,
                  ),
                  BottomNavItem(
                    unselectedIcon: 'assets/icons/favourite.svg',
                    selectedIcon: 'assets/icons/favroiteFill.svg',
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    isSelected: _selectedIndex == 1,
                  ),
                  BottomNavItem(
                    unselectedIcon: 'assets/icons/badge.svg',
                    selectedIcon: 'assets/icons/badgeFill.svg',
                    onTap: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                    isSelected: _selectedIndex == 2,
                  ),
                  BottomNavItem(
                    unselectedIcon: 'assets/icons/persion.svg',
                    selectedIcon: 'assets/icons/user_filled.svg',
                    onTap: () {
                      setState(() {
                        _selectedIndex = 3;
                      });
                    },
                    isSelected: _selectedIndex == 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.selectedIcon,
    required this.unselectedIcon,
  });
  final String selectedIcon;
  final String unselectedIcon;
  final VoidCallback onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            isSelected ? selectedIcon : unselectedIcon,
            height: 22.h,
          )
          // Image.asset(
          //   isSelected ? iconWhite : iconPath,
          //   height: 18.h,
          //   scale: 0.1,
          //   color: isSelected ? AppColors.brown : AppColors.grayDark,
          // ),
          ,
          SizedBox(
            height: 4.h,
          ),
          Center(
            child: SvgPicture.asset(
              'assets/icons/Vector 72.svg',
              color: isSelected ? const Color(0xff002140) : Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
