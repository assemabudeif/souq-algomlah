part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchUpdate extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<ProductModel> products;

  const SearchLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class AddToCartLoading extends SearchState {}

class AddToCartSuccess extends SearchState {}

class AddToCartError extends SearchState {}

class RemoveFromCartLoading extends SearchState {}

class RemoveFromCartSuccess extends SearchState {}

class RemoveFromCartError extends SearchState {}