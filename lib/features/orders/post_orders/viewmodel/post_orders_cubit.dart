import 'dart:developer';

import 'package:bloc/bloc.dart';
import '/core/services/cart/cart_service.dart';
import '/core/services/services_locator.dart';
import '/features/orders/model/post_order_request.dart';
import '/features/orders/repo/orders_repo.dart';

part 'post_orders_state.dart';

class PostOrderCubit extends Cubit<PostOrderState> {
  PostOrderCubit(this._authRepo) : super(PostOrderInitial());

  final OrdersRepo _authRepo;

  Future<void> postOrder(PostOrderRequest req) async {
    log('here');
    log('req: ${req.cart[0].product}');
    emit(PostOrderLoading());
    final result = await _authRepo.postOrder(req);
    result.fold(
      (error) {
        emit(PostOrderError(error.errMsg));
      },
      (user) {
        sl<CartService>().dropCart();
        emit(PostOrderSuccess(user.url));
      },
    );
  }
}
