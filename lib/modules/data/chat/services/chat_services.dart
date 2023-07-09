// import 'package:dio/dio.dart';

// import '../../../../common/widgets/k_snackbar.dart';
// import '../../../../core/services/intercepters.dart';

// Future userLogin(String email, String password) async {
//   Dio dio = getDioInstance();
//   try {
//     final response = await dio.post(
//       "users/login",
//       data: {
//         'email': email,
//         'password': password,
//       },
//     );
//     final loginResponse = LoginResponseModel.fromJson(response.data);

//     kSnackbar("Sucess", loginResponse.message, true);

//     return loginResponse;
//   } on DioException catch (error) {
//     kSnackbar("Login Failed", error.response?.data['error'], false);
//   }
// }
