class AppUrl {
  static String baseUrl =
      "https://raj-lines-backend-production.up.railway.app/api/v1";
  static String banner = "$baseUrl/banner";
  static String signInUrl = "$baseUrl/auth/login";
  static String signUpUrl = "$baseUrl/auth/register";
  static String verifyCode = "$baseUrl/auth/verifyOtp";
  static String resendCode = "$baseUrl/auth/sendOtp";
  static String forgotPassword = "$baseUrl/auth/sendForgotPasswordOtp";
  static String resetPassword = "$baseUrl/auth/resetPassword";
  static String mainCategoryUul = "$baseUrl/category/mainCategory";
  static String subCategoryOfMainUrl = "$baseUrl/category/mainCategory/";
  static String getProductByCalegoryUrl = "$baseUrl/product/category/";
  static String productDetailsUrl = "$baseUrl/product/";
  static String getWishlistUrl = "$baseUrl/wishlist";
  static String getCartlisturl = "$baseUrl/cart";
  static String updateQuntityUrl = "$baseUrl/cart/item/";
  static String paymentOrderUrl = "$baseUrl/order";
  static String profileUrl = "$baseUrl/user/";
}
