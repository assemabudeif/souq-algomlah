import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/services/services_locator.dart';
import '/features/contuct_us/views/contact_us_view.dart';
import '/features/orders/get_orders/view/all_orders_screen.dart';
import '/features/orders/get_orders/view/orders_details_screen.dart';
import '/features/orders/get_orders/viewmodel/get_all_orders/get_orders_cubit.dart';
import '/features/orders/get_orders/viewmodel/get_order_details/get_order_details_cubit.dart';
import '/features/privacy_policy/privacy_policy_view.dart';
import '/features/profile/views/change_password_view.dart';
import '/features/cart/views/cart_view.dart';
import '../../features/category_details/views/category_details_view.dart';
import '/features/change_language/views/change_language_view.dart';
import '../../features/product/views/product_details_view.dart';
import '/features/profile/views/profile_view.dart';
import '/features/search/views/search_view.dart';
import '/features/auth/forgetpassword/views/forget_password_view.dart';
import '/features/auth/forgetpassword/views/otp_view.dart';
import '/features/auth/forgetpassword/views/reset_password_view.dart';
import '/features/auth/login/views/login_view.dart';
import '/features/auth/registration/views/registration_view.dart';
import '/features/home/views/homeview.dart';
import '/features/language/views/language_view.dart';
import '/features/onboarding/views/on_boarding_view.dart';
import '/features/splash/views/splash_view.dart';

class AppRoutes {
  /// Base routes
  static const String initialRoute = '/';
  static const String onboardingRoute = '/onboarding';
  static const String languageRoute = '/language';

  /// Auth routes
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgetPasswordRoute = '/forget-password';
  static const String otpRoute = '/otp';
  static const String resetPasswordRoute = '/reset-password';

  /// Home routes
  static const String homeRoute = '/home';
  static const String searchRoute = '/search';
  static const String contactUsRoute = '/contact-us';
  static const String privacyPolicyRoute = '/privacy-policy';

  /// Product routes
  static const String productDetailsRoute = '/product-details';
  static const String categoryDetailsRoute = '/category-details';

  /// Change Language
  static const String changeLanguageRoute = '/change-language';

  /// Profile
  static const String profileRoute = '/profile';

  /// Orders
  static const String ordersRoute = '/orders';
  static const String orderDetailsScreen = '/orderDetailsScreen';

  /// Cart
  static const String cartRoute = '/cart';

  static const String changePasswordRoute = '/change-password';
}

class RoutesManager {
  static Route<dynamic>? Function(RouteSettings settings) onGenerateRoute =
      (settings) {
    switch (settings.name) {
      /// Base routes
      case AppRoutes.initialRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );
      case AppRoutes.onboardingRoute:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingView(),
        );
      case AppRoutes.languageRoute:
        return MaterialPageRoute(
          builder: (_) => const LanguageView(),
        );

      /// Auth routes
      case AppRoutes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
        );
      case AppRoutes.registerRoute:
        return MaterialPageRoute(
          builder: (_) => const RegistrationView(),
        );
      case AppRoutes.forgetPasswordRoute:
        return MaterialPageRoute(
          builder: (_) => ForgetPasswordView(
            email: settings.arguments as String? ?? '',
          ),
        );
      case AppRoutes.otpRoute:
        return MaterialPageRoute(
          builder: (_) => ResetPasswordOTPView(
            email: settings.arguments as String? ?? '',
          ),
        );
      case AppRoutes.resetPasswordRoute:
        return MaterialPageRoute(
          builder: (_) => ResetPasswordView(
            params: settings.arguments as ResetPasswordViewParams? ??
                ResetPasswordViewParams(
                  email: '',
                  otp: '',
                ),
          ),
        );

      /// Home routes
      case AppRoutes.homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
        );
      case AppRoutes.searchRoute:
        return MaterialPageRoute(
          builder: (_) => const SearchView(),
        );
      case AppRoutes.contactUsRoute:
        return MaterialPageRoute(
          builder: (_) => const ContactUsView(),
        );
      case AppRoutes.privacyPolicyRoute:
        return MaterialPageRoute(
          builder: (_) => const PrivacyPolicyView(),
        );

      /// Orders
      case AppRoutes.ordersRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<GetAllOrdersCubit>(
            create: (context) => sl<GetAllOrdersCubit>(),
            child: const AllOrdersScreen(),
          ),
        );
      case AppRoutes.orderDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<GetOrderDetailsCubit>(
            create: (context) => sl<GetOrderDetailsCubit>(),
            child: OrderDetailsScreen(
              orderId: (settings.arguments as List)[0] as String? ?? '',
              isPaided: (settings.arguments as List)[1] as bool? ?? false,
            ),
          ),
        );

      /// Product routes
      case AppRoutes.productDetailsRoute:
        return MaterialPageRoute(
          builder: (_) => ProductDetailsView(
            params: settings.arguments as ProductParams,
          ),
        );
      case AppRoutes.categoryDetailsRoute:
        return MaterialPageRoute(
          builder: (_) => CategoryDetailsView(
            categoryId: settings.arguments as String? ?? '',
          ),
        );

      /// Change Language\
      case AppRoutes.changeLanguageRoute:
        return MaterialPageRoute(
          builder: (_) => const ChangeLanguageView(),
        );

      /// Profile
      case AppRoutes.profileRoute:
        return MaterialPageRoute(
          builder: (_) => const ProfileView(),
        );
      case AppRoutes.changePasswordRoute:
        return MaterialPageRoute(
          builder: (_) => const ChangePasswordView(),
        );

      /// Cart
      case AppRoutes.cartRoute:
        return MaterialPageRoute(
          builder: (_) => const CartView(),
        );
      default:
        return null;
    }
  };
}
