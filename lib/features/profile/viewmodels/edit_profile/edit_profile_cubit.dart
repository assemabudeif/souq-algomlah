import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/constants/app_constance.dart';
import '/core/data/models/cities_model.dart';
import '/core/data/repo/cities_repo.dart';
import '/core/data/models/address_model.dart';
import '/core/data/requests/register_request.dart';
import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/extensions.dart';
import '/features/auth/login/model/login_model.dart';
import '/features/profile/models/repo/profile_repo.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this._profileRepo, this._citiesRepo)
      : super(EditProfileInitial());

  final ProfileRepo _profileRepo;
  final CitiesRepo _citiesRepo;

  final formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController additionalPhoneController =
      TextEditingController();
  final TextEditingController blockController = TextEditingController();
  final TextEditingController gadeController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController houseNoController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController apartmentNoController = TextEditingController();
  List<CityModel> cities = [];
  CityModel? selectedCity;

  init(BuildContext context) async {
    getCities(context);
    final loginModel = sl<AppPreferences>().getLoginModel();
    selectedCity = CityModel(
      id: "",
      name: loginModel.address.city,
      englishName: loginModel.address.cityEnglish,
      shippingCost: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      v: 0,
    );
    fullNameController.text = loginModel.username;
    phoneController.text = loginModel.phone;
    emailController.text = sl<AppPreferences>().getUserEmail();
    additionalPhoneController.text = '';
    blockController.text = loginModel.address.governorate;
    gadeController.text = loginModel.address.description;
    houseNoController.text = loginModel.address.homeNumber;
    floorController.text = loginModel.address.floorNumber;
    streetController.text = loginModel.address.street;
    apartmentNoController.text = loginModel.address.flatNumber;
  }

  dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    additionalPhoneController.dispose();
    blockController.dispose();
    gadeController.dispose();
    streetController.dispose();
    houseNoController.dispose();
    floorController.dispose();
    apartmentNoController.dispose();
  }

  void editProfile(BuildContext context) async {
    emit(EditProfileLoading());
    LoginModel loginModel = sl<AppPreferences>().getLoginModel();
    RegisterRequest request = RegisterRequest(
      name: fullNameController.text,
      email: emailController.text,
      phone: phoneController.text,
      secondPhone: additionalPhoneController.text,
      city: selectedCity?.name ?? loginModel.address.city,
      governorate: blockController.text,
      description: gadeController.text,
      homeNumber: houseNoController.text,
      floorNumber: floorController.text,
      street: streetController.text,
      flatNumber: apartmentNoController.text,
      password: '',
    );
    log(request.toJson().toString(), name: 'request');
    final result = await _profileRepo.editProfile(request);
    result.fold(
      (error) {
        if ((kAppLanguageCode == "en" && error.errMsg.contains("login")) ||
            (kAppLanguageCode == "ar" && error.errMsg.contains("تسجيل"))) {
          sl<AppPreferences>().clear();
          context.navigateToNamed(AppRoutes.loginRoute);
          context.showErrorSnackBar(error.errMsg);
          return;
        }
        context.showErrorSnackBar(error.errMsg);
        emit(EditProfileFailure());
      },
      (data) async {
        final newModel = loginModel.copyWith(
          username: fullNameController.text,
          points: data.points,
          wallet: data.wallet,
          id: data.id,
          address: AddressModel(
            city: selectedCity?.name ?? loginModel.address.city,
            cityEnglish:
                selectedCity?.englishName ?? loginModel.address.cityEnglish,
            governorate: blockController.text,
            street: streetController.text,
            homeNumber: houseNoController.text,
            floorNumber: floorController.text,
            flatNumber: apartmentNoController.text,
            description: gadeController.text,
          ),
        );
        await sl<AppPreferences>().setLoginModel(newModel);
        await sl<AppPreferences>()
            .setUserEmail(data.email ?? emailController.text);
        await sl<AppPreferences>().setPhone(data.phone ?? phoneController.text);
        await sl<AppPreferences>().setSecondPhone(
          data.secondPhone ?? additionalPhoneController.text,
        );
        await sl<AppPreferences>().setUserName(
          data.username ?? fullNameController.text,
        );
        log(sl<AppPreferences>().getLoginModel().toJson().toString(),
            name: 'loginModel');

        if (context.mounted) {
          context.showSuccessSnackBar(
            context.locale == const Locale('en')
                ? 'Profile updated successfully'
                : 'تم تحديث البيانات بنجاح',
          );
          context.navigateToNamed(AppRoutes.homeRoute);
        }
        emit(EditProfileSuccess());
      },
    );
  }

  changeCity(CityModel city) {
    emit(ChangeCityInitialState());
    selectedCity = city;
    emit(ChangeCityState());
  }

  void getCities(BuildContext context) async {
    emit(EditProfileGetCitiesLoadingState());
    final cities = await _citiesRepo.getCities();
    cities.fold(
      (failure) {
        this.cities = [];
        context.showErrorSnackBar(failure.errMsg);
        emit(EditProfileGetCitiesFailureState());
      },
      (cities) {
        this.cities = cities;
        emit(EditProfileGetCitiesSuccessState());
      },
    );
  }
}
