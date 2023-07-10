import 'package:dio/dio.dart';
import 'package:moury/modules/data/my_community/model/my_community_response_model.dart';

import '../../../../core/services/intercepters.dart';

class MyCommunityService {
  Future<MyCommunityResponseModel> getMyCommunity() async {
    Dio dio = getDioInstance();
    try {
      final response = await dio.get(
        "community/my",
      );

      return MyCommunityResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DioException(
        error: e.message,
        message: e.response?.data[0]["error"],
        requestOptions: RequestOptions(path: "community"),
      );
    }
  }
}
