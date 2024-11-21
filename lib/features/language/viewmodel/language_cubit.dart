import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/core/data/models/address_model.dart';
import '/core/data/models/cities_model.dart';
import '/core/data/repo/cities_repo.dart';
import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '/features/auth/login/model/login_model.dart';
import '/core/enums/languaage_enum.dart';
import '/core/functions/change_app_lang.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/extensions.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit(this._citiesRepo) : super(LanguageInitial());

  final CitiesRepo _citiesRepo;

  LanguageEnum? selectedLanguage;
  bool shopAsGuest = false;
  List<CityModel> cities = [];
  CityModel? selectedCity;

  void changeLanguage({
    required LanguageEnum languageCode,
    required BuildContext context,
  }) {
    emit(LanguageSelectedInitialState());
    selectedLanguage = languageCode;
    changeAppLang(langCode: languageCode.value, context: context);
    emit(LanguageSelectedState());
  }

  void shopAsGuestToggle() {
    emit(LanguageInitial());
    shopAsGuest = true;
    emit(LanguageShopAsGuestState());
  }

  Future<void> continueAsGuest(BuildContext context) async {
    await sl<AppPreferences>().setGustUser(true);
    await sl<AppPreferences>().setLoginModel(
      LoginModel(
        address: AddressModel(
          city: selectedCity?.name ?? '',
          cityEnglish: selectedCity?.englishName ?? '',
          street: '',
          homeNumber: '',
          governorate: '',
          floorNumber: '',
          flatNumber: '',
          description: '',
        ),
        phone: '',
        id: '',
        isAdmin: false,
        points: -1,
        token: '',
        username: '',
        verified: false,
        wallet: -1,
      ),
    );
    if (context.mounted) {
      if (selectedCity != null) {
        context.navigateToNamedWithPopUntil(AppRoutes.homeRoute);
      } else {
        context.showErrorSnackBar(
          context.locale == const Locale('en')
              ? 'Please select a city'
              : 'من فضلك اختر مدينة',
        );
      }
    }
  }

  void getCities(BuildContext context) async {
    emit(LanguageGetCitiesLoadingState());
    final cities = await _citiesRepo.getCities();
    cities.fold(
      (failure) {
        this.cities = [];
        context.showErrorSnackBar(failure.errMsg);
        emit(LanguageGetCitiesErrorState());
      },
      (cities) {
        this.cities = cities;
        emit(LanguageGetCitiesSuccessState());
      },
    );
  }
}
