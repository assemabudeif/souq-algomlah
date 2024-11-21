import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:souqalgomlah_app/features/home/model/main_baner_model.dart';
import '/features/home/model/user_model.dart';
import '/core/errors/fauilers.dart';
import '/core/network/api_constance.dart';
import '/core/utilities/dio_logger.dart';
import '/core/data/models/all_categories_model.dart';
import '/features/home/viewmodel/repo/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  @override
  Future<Either<Failure, AllCategoriesModel>> getAllCategories() async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.getAllCategories,
      );
      return Right(AllCategoriesModel.fromJson(response.data));
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.formDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserDetails() async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.getUserDetails,
      );
      return Right(UserModel.fromJson(response.data));
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.formDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MainBannerModel>>> getMainBanners() async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.mainBanners,
      );
      return Right(List<MainBannerModel>.from(
          response.data.map((json) => MainBannerModel.fromJson(json))));
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.formDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}
