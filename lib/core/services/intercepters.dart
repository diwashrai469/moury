import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:moury/core/services/network_services.dart';

import 'local_storage.dart';

Dio getDioInstance() {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://13.235.254.59:4000/api/v1/",
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = LocalStorageService().read(
          LocalStorageKeys.accessToken,
        );

        if (token != null) {
          options.headers['Authorization'] = "Bearer $token";
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        if (e.type == DioExceptionType.badResponse) {
          if (e.response!.statusCode == 401) {
            LocalStorageService().clear(LocalStorageKeys.accessToken);

            Future.delayed(const Duration(milliseconds: 100), () {
              Get.offAndToNamed('/login');
            });
          }
        }
        return handler.next(
          NetworkFailure(
              requestOptions: e.requestOptions,
              error: e.error,
              response: e.response,
              type: e.type),
        );
      },
    ),
  );

  return dio;
}
