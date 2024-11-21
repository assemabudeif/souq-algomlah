import '/core/constants/app_constance.dart';

class ApiConstance {
  static const String baseUrl = 'https://backend.souqalgomlah.com/';
  static String token = '';

  static const String currentVersion = "version";

  /// Auth
  static const String login = 'auth/login';
  static const String register = 'auth/register';

  static String verify(String email) => 'auth/verify/$email';

  static String sendOTPForResetPassword(String email) => 'reset/otp/$email';

  static String resendOTP(String email) => 'auth/resend-mail/$email';

  static String verifyOTPForResetPassword(String email) =>
      'reset/verify-otp/$email';

  static String resetPassword(String email) => 'reset/newpassword/$email';
  static final String updateProfile = 'users/$kUserId';
  static final String deleteUser = 'users/$kUserId';

  static final String fcmToken = "Users/set-fcm/$kUserId";

  /// Home
  static const String getAllCategories = 'categories';
  static String getUserDetails = 'users/$kUserId';
  static const String mainBanners = '/main-banners';

  /// Category
  static String getCategory(String categoryId) => 'categories/$categoryId';

  /// Search
  static String search(String searchText) =>
      'products/search/$kAppLanguageCode/$searchText';

  /// Cities
  static const String getCities = 'cities';

  /// Product
  static String getProduct(String productId) => 'products/$productId';

  /// order-minimum-cost
  static const String orderMinimumCost = 'order-minimum-cost';
}
