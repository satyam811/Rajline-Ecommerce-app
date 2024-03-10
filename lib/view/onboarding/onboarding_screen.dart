import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raj_lines/view/auth/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  List<OnboardingItem> onboardingItem = [
    OnboardingItem(
      title: 'Welcome To\nRaj Line',
      des:
          'Get ready for a personalized shopping\n experience like never before',
      image: 'assets/icons/onbording1.png',
    ),
    OnboardingItem(
      title: 'How To Order?',
      des:
          'Step 1 : Select Items\nStep 2 : Add to Cart\nStep 3 : Place Order',
      image: 'assets/icons/onboarding2.png',
    ),
    OnboardingItem(
      title: 'Have a Nice Day',
      des:
          'Thank You for choosing\nRaj Line!\nStay Connected',
      image: 'assets/icons/onboarding2.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.h),
              child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _controller.jumpToPage(2);
                        _currentPage = 2;
                      });
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xff9D9D9D)),
                    ),
                  )),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: onboardingItem.length,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left:20.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Image.asset(
                              onboardingItem[index].image,
                              height: 526.h,
                            )),
                      ),
                      Positioned(
                          right: 0.0,
                          top: 165,
                          child:  Image.asset(
                  'assets/icons/tiger.png',

                  )),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 320.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(29),
                                  topRight: Radius.circular(29)),
                              color: Color(0xffF6762F),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(3.0, 0),
                                    color: Colors.black.withOpacity(0.25),
                                    // spreadRadius: 15,
                                    blurRadius: 4)
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 30.h,
                              ),
                              Center(
                                  child: Text(
                                onboardingItem[index].title,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter
                                  (fontSize: 26, color: Colors.white,fontWeight: FontWeight.w600)),),
                              SizedBox(
                                height: 22.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0.w),
                                child: Center(
                                    child: Text(
                                  onboardingItem[index].des,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter
                                    (fontSize: 18, color: Colors.white,fontWeight: FontWeight.w400)
                                )),
                              ),
                              SizedBox(
                                height: 47.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 29.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _currentPage == 0
                                        ? const SizedBox(
                                            height: 35,
                                            width: 35,
                                          )
                                        : InkWell(
                                            onTap: () {
                                              _controller.previousPage(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.easeIn);
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                  border: Border.all(
                                                      color:  Colors.black,
                                                      width: 2)),
                                              child: const Icon(
                                                Icons.arrow_back,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: onboardingItem.map((image) {
                                        int index =
                                            onboardingItem.indexOf(image);
                                        return Container(
                                          width: 10.w,
                                          height: 10.h,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _currentPage == index
                                                ?  Colors.black
                                                : Color(0xffD9D9D9),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (_currentPage ==
                                            onboardingItem.length - 1) {
                                          if (kDebugMode) {
                                            print('redirect');
                                          }
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen(),
                                          ));
                                        }
                                        if (_currentPage <
                                            onboardingItem.length - 1) {
                                          _controller.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeIn);
                                        }
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 2),
                                            color: Colors.black),
                                        child: const Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingItem {
  final String title;
  final String des;
  final String image;

  OnboardingItem({required this.title, required this.des, required this.image});
}
