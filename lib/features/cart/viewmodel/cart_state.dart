part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class GetCartItemsLoading extends CartState {}

class GetCartItemsSuccess extends CartState {}

class GetCartItemsFailed extends CartState {}

class CartGetCitiesLoadingState extends CartState {}

class CartGetCitiesSuccessState extends CartState {}

class CartGetCitiesErrorState extends CartState {}

class PostOrderLoading extends CartState {}

class PostOrderSuccess extends CartState {
  final String? url;

  const PostOrderSuccess(this.url);
}

class PostOrderError extends CartState {
  final String errorMsg;

  const PostOrderError(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
