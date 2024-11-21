import 'package:dio/dio.dart';

import '/core/network/api_constance.dart';

class DioLogger {
  static Dio getDio() {
    Dio dio = Dio();

    dio.options.baseUrl = ApiConstance.baseUrl;

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'token': ApiConstance.token,
    };

    // dio.interceptors.add(
    //   PrettyDioLogger(
    //     requestHeader: true,
    //     requestBody: true,
    //     responseBody: true,
    //     request: true,
    //     compact: true,
    //     error: true,
    //     responseHeader: true,
    //     logPrint: (object) {
    //       debugPrint(object.toString());
    //     },
    //   ),
    // );
    return dio;
  }
}
