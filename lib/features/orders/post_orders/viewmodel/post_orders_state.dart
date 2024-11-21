part of 'post_orders_cubit.dart';

abstract class PostOrderState {}

class PostOrderInitial extends PostOrderState {}

class PostOrderLoading extends PostOrderState {}

class PostOrderSuccess extends PostOrderState {
  final String? url;
  PostOrderSuccess(this.url);
}

class PostOrderError extends PostOrderState {
  final String errorMsg;
  PostOrderError(this.errorMsg);
}
