part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class GetProfileDataLoading extends ProfileState {}

class GetProfileDataSuccess extends ProfileState {
  final ProfileViewModel profileModel;

  const GetProfileDataSuccess(this.profileModel);

  @override
  List<Object> get props => [profileModel];
}

class GetProfileDataError extends ProfileState {
  final String error;

  const GetProfileDataError(this.error);

  @override
  List<Object> get props => [error];
}

class DeleteUserLoading extends ProfileState {}

class DeleteUserSuccess extends ProfileState {}

class DeleteUserError extends ProfileState {}
