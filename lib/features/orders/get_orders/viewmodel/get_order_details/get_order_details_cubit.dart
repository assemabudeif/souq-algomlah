import 'dart:developer';

import 'package:bloc/bloc.dart';
import '/features/orders/model/order_details_response.dart';
import '/features/orders/repo/orders_repo.dart';

part 'get_order_details_state.dart';

class GetOrderDetailsCubit extends Cubit<GetOrderDetailsState> {
  GetOrderDetailsCubit(this._ordersRepo) : super(GetOrderDetailsInitial());

  final OrdersRepo _ordersRepo;
  double? totalPrice;

  Future<void> getOrderDetails({
    required String orderId,
    required String userId,
  }) async {
    emit(GetOrderDetailsLoading());
    final result = await _ordersRepo.getOrderDetails(
      orderId: orderId,
      userId: userId,
    );
    result.fold(
      (error) {
        log('message: ${error.errMsg}');
        emit(GetOrderDetailsError(error.errMsg));
      },
      (user) {
        totalPrice = user.totalCost! - user.shippingCost!;
        emit(
          GetOrderDetailsSuccess(
            user,
          ),
        );
      },
    );
  }
}
