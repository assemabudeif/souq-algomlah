part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductUpdate extends ProductState {}

class GetProductDetailsLoading extends ProductState {}

class GetProductDetailsSuccess extends ProductState {}

class GetProductDetailsError extends ProductState {}
