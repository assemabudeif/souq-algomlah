part of 'edit_profile_cubit.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {}

class EditProfileFailure extends EditProfileState {}

class ChangeCityInitialState extends EditProfileState {}

class ChangeCityState extends EditProfileState {}

class EditProfileGetCitiesLoadingState extends EditProfileState {}

class EditProfileGetCitiesSuccessState extends EditProfileState {}

class EditProfileGetCitiesFailureState extends EditProfileState {}
