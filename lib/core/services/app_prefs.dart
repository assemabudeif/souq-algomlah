import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/core/data/models/address_model.dart';
import '/features/auth/login/model/login_model.dart';

import '/core/network/api_constance.dart';
import '../constants/app_constance.dart';
import 'services_locator.dart';

enum SharedKey {
  firstTime,
  token,
  language,
  isDarkMode,
  userId,
  userName,
  userEmail,
  loginModel,
  phone,
  secondPhone,
  gustUser,
}

class AppPreferences {
  final _sharedPreferences = sl<SharedPreferences>();

  Future<void> init(BuildContext context, {bool fromLogin = false}) async {
    if (getAppLanguageCode() == '') {
      kAppLanguageCode =
          getAppLanguageCode() ?? context.deviceLocale.languageCode;
      setAppLanguageCode(kAppLanguageCode);
      // context.setLocale(Locale(kAppLanguageCode));
    } else {
      kAppLanguageCode =
          getAppLanguageCode() ?? context.deviceLocale.languageCode;
      // context.setLocale(Locale(kAppLanguageCode));
    }
    if (!fromLogin) {
      kUserId = getUserId();
    }
    kFirstTime = getFirstTime();
    ApiConstance.token = getToken();
    kUserName = getUserName();
    EasyLocalization.of(context)!.setLocale(Locale(kAppLanguageCode));

    await Future.delayed(const Duration(seconds: 1), () {
      log(kAppLanguageCode, name: 'Language Code');
      log(kFirstTime.toString(), name: 'First Time');
      log(ApiConstance.token, name: 'Token');
      log(kUserId, name: 'User ID');
    });
  }

  /// Save the first time to the shared preferences
  Future<void> setFirstTime(bool isFirstTime) async {
    await _sharedPreferences.setBool(
      SharedKey.firstTime.toString(),
      isFirstTime,
    );
  }

  /// Get the first time from the shared preferences
  bool getFirstTime() {
    return _sharedPreferences.getBool(SharedKey.firstTime.toString()) ?? true;
  }

  /// Save the SessionId to the shared preferences
  Future<void> setToken(String token) async {
    ApiConstance.token = token;
    await _sharedPreferences.setString(
      SharedKey.token.toString(),
      token,
    );
  }

  /// Get the SessionId from the shared preferences
  String getToken() {
    return _sharedPreferences.getString(SharedKey.token.toString()) ?? '';
  }

  /// Remove the SessionId from the shared preferences
  Future<void> removeToken() async {
    ApiConstance.token = '';
    await _sharedPreferences.remove(SharedKey.token.toString());
  }

  /// Save the SessionId to the shared preferences
  Future<void> setAppLanguageCode(String languageCode) async {
    await _sharedPreferences.setString(
      SharedKey.language.toString(),
      languageCode,
    );
  }

  /// Get the SessionId from the shared preferences
  String? getAppLanguageCode() {
    return _sharedPreferences.getString(SharedKey.language.toString());
  }

  /// Remove the SessionId from the shared preferences
  Future<void> removeLanguageCode() async {
    await _sharedPreferences.remove(SharedKey.language.toString());
  }

  /// Save the userId to the shared preferences
  Future<void> setUserId(String userId) async {
    await _sharedPreferences.setString(
      SharedKey.userId.toString(),
      userId,
    );
  }

  /// Get the userId from the shared preferences
  String getUserId() {
    return _sharedPreferences.getString(SharedKey.userId.toString()) ?? '';
  }

  /// Remove the userId from the shared preferences
  Future<void> removeUserId() async {
    await _sharedPreferences.remove(SharedKey.userId.toString());
  }

  /// Save the userName to the shared preferences
  Future<void> setUserName(String userName) async {
    await _sharedPreferences.setString(
      SharedKey.userName.toString(),
      userName,
    );
  }

  /// Get the userName from the shared preferences
  String getUserName() {
    return _sharedPreferences.getString(SharedKey.userName.toString()) ?? '';
  }

  /// Remove the userName from the shared preferences
  Future<void> removeUserName() async {
    await _sharedPreferences.remove(SharedKey.userName.toString());
  }

  /// Save the userEmail to the shared preferences
  Future<void> setUserEmail(String userEmail) async {
    await _sharedPreferences.setString(
      SharedKey.userEmail.toString(),
      userEmail,
    );
  }

  /// Get the userEmail from the shared preferences
  String getUserEmail() {
    return _sharedPreferences.getString(SharedKey.userEmail.toString()) ?? '';
  }

  /// Remove the userEmail from the shared preferences
  Future<void> removeUserEmail() async {
    await _sharedPreferences.remove(SharedKey.userEmail.toString());
  }

  /// Save the login mmodel to the shared preferences
  Future<void> setLoginModel(LoginModel loginModel) async {
    await _sharedPreferences.setString(
      SharedKey.loginModel.toString(),
      json.encode(loginModel.toJson()),
    );
  }

  /// Get the login mmodel from the shared preferences
  LoginModel getLoginModel() {
    if (_sharedPreferences.getString(SharedKey.loginModel.toString()) != null) {
      return LoginModel.fromJson(
        json.decode(
          _sharedPreferences.getString(SharedKey.loginModel.toString()) ?? '',
        ),
      );
    }
    return const LoginModel(
      token: '',
      id: '',
      isAdmin: false,
      points: -1,
      username: "",
      verified: false,
      wallet: -1,
      phone: "",
      address: AddressModel(
        city: "",
        description: "",
        flatNumber: "",
        floorNumber: "",
        governorate: "",
        homeNumber: "",
        street: "",
      ),
    );
  }

  /// Remove the login mmodel from the shared preferences
  Future<void> removeLoginModel() async {
    await _sharedPreferences.remove(SharedKey.loginModel.toString());
  }

  /// Save the phone to the shared preferences
  Future<void> setPhone(String phone) async {
    await _sharedPreferences.setString(
      SharedKey.phone.toString(),
      phone,
    );
  }

  /// Get the phone from the shared preferences
  String getPhone() {
    return _sharedPreferences.getString(SharedKey.phone.toString()) ?? '';
  }

  /// Remove the phone from the shared preferences
  Future<void> removePhone() async {
    await _sharedPreferences.remove(SharedKey.phone.toString());
  }

  /// Save the second phone to the shared preferences
  Future<void> setSecondPhone(String secondPhone) async {
    await _sharedPreferences.setString(
      SharedKey.secondPhone.toString(),
      secondPhone,
    );
  }

  /// Get the second phone from the shared preferences
  String getSecondPhone() {
    return _sharedPreferences.getString(SharedKey.secondPhone.toString()) ?? '';
  }

  /// Remove the second phone from the shared preferences
  Future<void> removeSecondPhone() async {
    await _sharedPreferences.remove(SharedKey.secondPhone.toString());
  }

  /// Save the gust user to the shared preferences
  Future<void> setGustUser(bool isGustUser) async {
    await _sharedPreferences.setBool(
      SharedKey.gustUser.toString(),
      isGustUser,
    );
  }

  /// Get the gust user from the shared preferences
  bool getGustUser() {
    return _sharedPreferences.getBool(SharedKey.gustUser.toString()) ?? false;
  }

  /// Remove the gust user from the shared preferences
  Future<void> removeGustUser() async {
    await _sharedPreferences.remove(SharedKey.gustUser.toString());
  }

  /// Clear all the shared preferences
  Future<void> clear() async {
    await _sharedPreferences.clear();
  }
}
