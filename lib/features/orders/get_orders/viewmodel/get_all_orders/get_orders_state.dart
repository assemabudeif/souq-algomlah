part of 'get_orders_cubit.dart';

abstract class GetAllOrdersState {}

class GetAllOrdersInitial extends GetAllOrdersState {}

class GetAllOrdersLoading extends GetAllOrdersState {}

class GetAllOrdersSuccess extends GetAllOrdersState {
  final List<GetAllOrdersResponse> orders;
  GetAllOrdersSuccess(this.orders);
}

class GetAllOrdersError extends GetAllOrdersState {
  final String errorMsg;
  GetAllOrdersError(this.errorMsg);
}
