import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '/core/constants/app_constance.dart';

abstract class Failure {
  final String errMsg;

  const Failure(this.errMsg);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMsg);

  factory ServerFailure.formDioException(DioException dioException) {
    if (dioException.message?.contains("token") ?? false) {
      return ServerFailure(kAppLanguageCode == 'en'
          ? 'Your session has expired, please login again'
          : 'انتهت جلستك, الرجاء تسجيل الدخول مرة اخرى');
    }
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Recieve timeout with ApiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');
      case DioExceptionType.cancel:
        return ServerFailure('Your Request with ApiServer was canceled');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.badCertificate:
        return ServerFailure('Failed to authenticate with ApiServer');
      case DioExceptionType.connectionError:
        return ServerFailure('There was a Connection error with the Server');
      case DioExceptionType.unknown:
        if (dioException.message?.contains('SocketException') ?? false) {
          return ServerFailure('Check your internet connection please');
        }
        return ServerFailure('There was an unkown error with the Server');
      default:
        return ServerFailure('There was an unkown error with the Server');
    }
  }

  factory ServerFailure.fromResponse(
    int statusCode,
    dynamic respone, {
    BuildContext? context,
  }) {
    if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 404) {
      try {
        if (respone['message'].toString().contains("token")) {
          return ServerFailure(kAppLanguageCode == 'en'
              ? 'Your session has expired, please login again'
              : 'انتهت جلستك, الرجاء تسجيل الدخول مرة اخرى');
        }
        return ServerFailure(respone['message'].toString());
      } catch (e) {
        log(e.toString());
        return ServerFailure(respone.toString());
      }
    } else if (statusCode == 403) {
      return ServerFailure('Your Request not found, please try again later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server error, please try again later!');
    } else {
      return ServerFailure('Oops! There was an error, please try again later');
    }
  }
}

/*
* if (dioException.message!.contains("token") && context != null) {
      context.showErrorSnackBar(
        context.locale == const Locale('en')
            ? 'Your session has expired, please login again'
            : 'انتهت جلستك, الرجاء تسجيل الدخول مرة اخرى',
      );

      context.navigateToNamedWithPopUntil(AppRoutes.loginRoute);
    }
*/
