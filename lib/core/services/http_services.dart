// import 'package:dio/dio.dart';
// import 'package:get/get.dart';

// import 'local_storage.dart';
// import 'network_services.dart';

// class HttpService {
//   late final Dio _dio;
//   Dio get http => _dio;
//   // final LocalStorageService _localStorageService;

//   HttpService(
//     // this._localStorageService,
//   ) {
//     _dio = Dio();
//     _dio.options.baseUrl = "http://13.235.254.59:4000/api/v1/";
//     _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
//       String? token = _localStorageService.read(LocalStorageKeys.accessToken);
//       if (token != null) {
//         options.headers['Authorization'] = "Bearer $token";
//       }
//       return handler.next(options); //continue
//     }, onResponse: (response, handler) {
//       return handler.next(response); // continue
//     }, onError: (DioError e, handler) {
//       if (e.type == DioErrorType.unknown) {
//         if (e.response!.statusCode == 401) {
//           _localStorageService.clear(LocalStorageKeys.accessToken);

//           Future.delayed(const Duration(milliseconds: 100), () {
//             Get.offAndToNamed("/login");
//           });
//         }
//       }
//       return handler.next(
//         NetworkFailure(
//           requestOptions: e.requestOptions,
//           error: e.error,
//           response: e.response,
//           type: e.type,
//         ),
//       ); //continue
//     }));
//   }
// }
