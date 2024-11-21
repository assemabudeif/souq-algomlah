import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:souqalgomlah_app/features/product/model/repo/product_repo.dart';
import 'package:souqalgomlah_app/features/product/model/repo/product_repo_impl.dart';
import 'package:souqalgomlah_app/features/product/viewmodel/product_cubit.dart';
import '/core/data/repo/cities_repo.dart';
import '/core/data/repo/cities_repo_impl.dart';
import '/features/orders/get_orders/viewmodel/get_all_orders/get_orders_cubit.dart';
import '/features/orders/get_orders/viewmodel/get_order_details/get_order_details_cubit.dart';
import '/features/orders/post_orders/viewmodel/post_orders_cubit.dart';
import '/features/orders/repo/orders_repo.dart';
import '/features/orders/repo/orders_repo_impl.dart';
import '/features/profile/viewmodels/change_password/change_password_cubit.dart';
import '/features/cart/viewmodel/cart_cubit.dart';
import '/features/profile/models/repo/profile_repo.dart';
import '/features/profile/models/repo/profile_repo_impl.dart';
import '/features/profile/viewmodels/edit_profile/edit_profile_cubit.dart';
import '/features/profile/viewmodels/profile/profile_cubit.dart';
import '/core/services/cart/cart_service.dart';
import '/core/services/favorite/favorite_service.dart';
import '/features/category_details/model/category_details_repo.dart';
import '/features/category_details/model/category_details_repo_impl.dart';
import '/features/category_details/viewmodel/category_details_cubit.dart';
import '/features/home/viewmodel/repo/home_repo.dart';
import '/features/home/viewmodel/repo/home_repo_impl.dart';
import '/features/search/model/search_repo.dart';
import '/features/search/model/search_repo_impl.dart';
import '/features/search/viewmodel/search_cubit.dart';
import '/features/change_language/viewmodel/change_language_cubit.dart';
import '/features/auth/forgetpassword/viewmodel/forget_password_cubit.dart';
import '/features/auth/login/viewmodel/login_cubit.dart';
import '/features/auth/registration/viewmodel/registration_cubit.dart';
import '/features/auth/repo/auth_repo.dart';
import '/features/auth/repo/auth_repo_impl.dart';
import '../../features/home/viewmodel/cubit/home_cubit.dart';
import '/features/language/viewmodel/language_cubit.dart';
import '/features/onboarding/viewmodel/on_boarding_cubit.dart';

import '/core/services/app_prefs.dart';

final sl = GetIt.instance;

class ServicesLocator {
  Future<void> init() async {
    /// Initialize SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => prefs);

    /// Initialize AppPreferences
    sl.registerLazySingleton<AppPreferences>(() => AppPreferences());

    /// Initialize FavoriteService
    sl.registerLazySingleton<FavoriteService>(() => FavoriteService());

    /// Initialize CartService
    sl.registerLazySingleton<CartService>(() => CartService());
    sl.registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl());
    sl.registerLazySingleton<CitiesRepo>(() => CitiesRepoImpl());

    /// Initialize OrdersRepo
    sl.registerLazySingleton<OrdersRepo>(() => OrdersRepoImpl());

    /// Blocs
    // General Blocs
    sl.registerFactory(() => OnBoardingCubit());
    sl.registerFactory(() => LanguageCubit(sl<CitiesRepo>()));
    sl.registerFactory(() => ChangeLanguageCubit());

    // Auth Blocs
    sl.registerFactory(() => LoginCubit(sl<AuthRepo>()));
    sl.registerFactory(() => RegistrationCubit(sl<AuthRepo>()));
    sl.registerFactory(() => ForgetPasswordCubit(sl<AuthRepo>()));

    // Home Blocs
    sl.registerFactory(() => HomeCubit(sl<HomeRepo>()));
    sl.registerFactory(() => SearchCubit(sl<SearchRepo>()));

    // Category Details Blocs
    sl.registerFactory(() => CategoryDetailsCubit(sl<CategoryDetailsRepo>()));

    // Order Blocs
    sl.registerFactory(() => PostOrderCubit(sl<OrdersRepo>()));
    sl.registerFactory(() => GetAllOrdersCubit(sl<OrdersRepo>()));
    sl.registerFactory(() => GetOrderDetailsCubit(sl<OrdersRepo>()));

    // Profile Blocs
    sl.registerFactory(() => ProfileCubit(sl<AuthRepo>()));
    sl.registerFactory(() => ChangePasswordCubit(sl<ProfileRepo>()));
    sl.registerFactory(() => EditProfileCubit(
          sl<ProfileRepo>(),
          sl<CitiesRepo>(),
        ));

    // Cart Cubit
    sl.registerFactory(() => CartCubit(
          sl<CartService>(),
          sl<CitiesRepo>(),
          sl<OrdersRepo>(),
        ));

    // Product Cubit
    sl.registerFactory(() => ProductCubit(sl<ProductRepo>()));

    /// Repositories
    sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl());
    sl.registerLazySingleton<HomeRepo>(() => HomeRepoImpl());
    sl.registerLazySingleton<SearchRepo>(() => SearchRepoImpl());
    sl.registerLazySingleton<ProductRepo>(() => ProductRepoImpl());
    sl.registerLazySingleton<CategoryDetailsRepo>(
      () => CategoryDetailsRepoImpl(),
    );
  }
}
