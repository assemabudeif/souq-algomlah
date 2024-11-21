part of 'category_details_cubit.dart';

abstract class CategoryDetailsState extends Equatable {
  const CategoryDetailsState();

  @override
  List<Object> get props => [];
}

class CategoryDetailsInitial extends CategoryDetailsState {}

class CategoryDetailsUpdate extends CategoryDetailsState {}

class CategoryDetailsError extends CategoryDetailsState {
  final String error;

  const CategoryDetailsError(this.error);

  @override
  List<Object> get props => [error];
}

class GetCategoryDetailsLoadingState extends CategoryDetailsState {}

class GetCategoryDetailsSuccessState extends CategoryDetailsState {}

class GetCategoryDetailsErrorState extends CategoryDetailsState {}

class ChangePageIndexState extends CategoryDetailsState {}

class AddToCartLoading extends CategoryDetailsState {}

class AddToCartSuccess extends CategoryDetailsState {}

class AddToCartError extends CategoryDetailsState {}

class RemoveFromCartLoading extends CategoryDetailsState {}

class RemoveFromCartSuccess extends CategoryDetailsState {}

class RemoveFromCartError extends CategoryDetailsState {}
