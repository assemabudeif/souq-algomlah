part of 'get_order_details_cubit.dart';

abstract class GetOrderDetailsState {}

class GetOrderDetailsInitial extends GetOrderDetailsState {}

class GetOrderDetailsLoading extends GetOrderDetailsState {}

class GetOrderDetailsSuccess extends GetOrderDetailsState {
  final OrderDetailsResponse order;
  GetOrderDetailsSuccess(this.order);
}

class GetOrderDetailsError extends GetOrderDetailsState {
  final String errorMsg;
  GetOrderDetailsError(this.errorMsg);
}
