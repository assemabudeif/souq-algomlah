import 'package:dartz/dartz.dart';
import '/features/orders/model/get_all_orders_response.dart';
import '/features/orders/model/order_details_response.dart';
import '/features/orders/model/post_order_request.dart';
import '/features/orders/model/post_order_response.dart';

import '/core/errors/fauilers.dart';

abstract class OrdersRepo {
  Future<Either<Failure, PostOrderResponse>> postOrder(PostOrderRequest req);

  Future<Either<Failure, List<GetAllOrdersResponse>>> getAllOrders();

  Future<Either<Failure, OrderDetailsResponse>> getOrderDetails({
    required String orderId,
    required String userId,
  });

  Future<Either<Failure, num>> getMinimumOrderCost();
}
