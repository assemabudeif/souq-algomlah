import 'package:dartz/dartz.dart';
import 'package:souqalgomlah_app/features/home/model/main_baner_model.dart';
import '/features/home/model/user_model.dart';
import '/core/errors/fauilers.dart';
import '/core/data/models/all_categories_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, AllCategoriesModel>> getAllCategories();

  Future<Either<Failure, UserModel>> getUserDetails();

  Future<Either<Failure, List<MainBannerModel>>> getMainBanners();
}
