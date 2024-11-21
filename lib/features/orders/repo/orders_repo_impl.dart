import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:souqalgomlah_app/core/network/api_constance.dart';
import '/core/errors/fauilers.dart';
import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '/core/utilities/dio_logger.dart';
import '/features/orders/model/get_all_orders_response.dart';
import '/features/orders/model/order_details_response.dart';
import '/features/orders/model/post_order_request.dart';
import '/features/orders/model/post_order_response.dart';

import 'orders_repo.dart';

class OrdersRepoImpl extends OrdersRepo {
  @override
  Future<Either<Failure, PostOrderResponse>> postOrder(
      PostOrderRequest req) async {
    try {
      log('${sl<AppPreferences>().getUserId()} this is the id of the user');
      log(req.toJson().toString());
      final response = await DioLogger.getDio().post(
          'orders?id=${sl<AppPreferences>().getUserId()}',
          data: req.toJson());
      return Right(PostOrderResponse.fromJson(response.data));
    } catch (error) {
      if (error is DioException) {
        log(error.toString());
        log(error.response!.statusCode.toString(), name: 'status code');
        return Left(ServerFailure.formDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GetAllOrdersResponse>>> getAllOrders() async {
    log(sl<AppPreferences>().getUserId().toString());
    log(sl<AppPreferences>().getToken().toString());
    try {
      final response = await DioLogger.getDio().get(
        'orders/user?id=${sl<AppPreferences>().getUserId()}',
      );
      List<dynamic> data = response.data;
      List<GetAllOrdersResponse> orders =
          data.map((e) => GetAllOrdersResponse.fromJson(e)).toList();
      log(orders.length.toString());
      return Right(orders);
    } catch (error) {
      if (error is DioException) {
        log(error.toString());
        return Left(ServerFailure.formDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderDetailsResponse>> getOrderDetails(
      {required String orderId, required String userId}) async {
    log(sl<AppPreferences>().getUserId().toString());
    log(sl<AppPreferences>().getToken().toString());
    try {
      final response = await DioLogger.getDio().get(
        'orders/$orderId?id=${sl<AppPreferences>().getUserId()}',
      );
      OrderDetailsResponse orders =
          OrderDetailsResponse.fromJson(response.data);

      return Right(orders);
    } catch (error) {
      if (error is DioException) {
        log(error.toString());
        return Left(ServerFailure.formDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, num>> getMinimumOrderCost() async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.orderMinimumCost,
      );
      return Right(response.data['orderMinimumCost'] as num? ?? 0);
    } catch (error) {
      if (error is DioException) {
        log(error.toString());
        return Left(ServerFailure.formDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}
