import 'dart:developer';

import 'package:bloc/bloc.dart';
import '/features/orders/model/get_all_orders_response.dart';
import '/features/orders/repo/orders_repo.dart';

part 'get_orders_state.dart';

class GetAllOrdersCubit extends Cubit<GetAllOrdersState> {
  GetAllOrdersCubit(this._ordersRepo) : super(GetAllOrdersInitial());

  final OrdersRepo _ordersRepo;

  Future<void> getAllOrders() async {
    emit(GetAllOrdersLoading());
    final result = await _ordersRepo.getAllOrders();
    result.fold(
      (error) {
        log('message: ${error.errMsg}');
        emit(GetAllOrdersError(error.errMsg));
      },
      (user) {
        log(user.length.toString());
        emit(
          GetAllOrdersSuccess(
            user,
          ),
        );
      },
    );
  }
}
