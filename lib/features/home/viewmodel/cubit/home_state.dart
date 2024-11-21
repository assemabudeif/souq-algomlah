part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeUpdate extends HomeState {}

class HomeOpenDrawerState extends HomeState {}

class GetHomeDataLoadingDate extends HomeState {}

class GetHomeDataSuccessDate extends HomeState {}

class GetHomeDataErrorDate extends HomeState {}

class AddToCartLoading extends HomeState {}

class AddToCartSuccess extends HomeState {}

class AddToCartError extends HomeState {}

class RemoveFromCartLoading extends HomeState {}

class RemoveFromCartSuccess extends HomeState {}

class RemoveFromCartError extends HomeState {}

class GetUserDetailsLoading extends HomeState {}

class GetUserDetailsSuccess extends HomeState {}

class GetUserDetailsError extends HomeState {}

class GetMainBannersLoading extends HomeState {}

class GetMainBannersSuccess extends HomeState {}

class GetMainBannersError extends HomeState {}
