import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:raj_lines/provider/auth_provider.dart';
import 'package:raj_lines/provider/cart_provider.dart';
import 'package:raj_lines/provider/category_provider.dart';
import 'package:raj_lines/provider/details_provider.dart';
import 'package:raj_lines/provider/home_provider.dart';
import 'package:raj_lines/provider/order_provider.dart';
import 'package:raj_lines/provider/payment_provider.dart';
import 'package:raj_lines/provider/productby_category_provider.dart';
import 'package:raj_lines/provider/profile_provider.dart';
import 'package:raj_lines/provider/wishlist_provider.dart';
import 'package:raj_lines/res/colors.dart';
import 'package:raj_lines/utils/shared_prefs.dart';
import 'package:raj_lines/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.instance().init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      designSize: const Size(360, 800),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => HomeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => CategoryProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ProductByCategoryProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ProductDetailsProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => WishlistProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => CartProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => PaymentProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => OrderProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ProfileProvider(),
          )
        ],
        child: MaterialApp(
            title: 'Raj Line',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  backgroundColor: AppColor.blueButtonColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  textStyle: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            home: Builder(
              builder: (context) {
                // return MainScreen();
                return const SplashScreen();
              },
            )),
      ),
    );
  }
}
