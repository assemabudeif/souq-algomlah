import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:souqalgomlah_app/core/errors/fauilers.dart';
import 'package:souqalgomlah_app/core/network/api_constance.dart';
import 'package:souqalgomlah_app/core/services/notifications_service.dart';
import 'package:souqalgomlah_app/core/utilities/dio_logger.dart';

Future<Either<Failure, String>> sendFCM() async {
  try {
    final response =
        await DioLogger.getDio().post(ApiConstance.fcmToken, data: {
      "fcmToken": await NotificationsService.getFCMToken(),
    });
    return const Right("Update FCM Token Successfully");
  } catch (e) {
    if (e is DioException) {
      return Left(ServerFailure.formDioException(e));
    }
    return Left(ServerFailure(e.toString()));
  }
}
