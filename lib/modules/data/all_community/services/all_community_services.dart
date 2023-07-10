import 'package:dio/dio.dart';
import 'package:moury/modules/data/all_community/models/all_community_response_model.dart';

import '../../../../core/services/intercepters.dart';
import '../models/join_community.dart';

class AllCommunityService {
  Future<JoinCommunityResponseModel> joinCommunity(String communityId) async {
    Dio dio = getDioInstance();
    try {
      final response = await dio.post(
        "community/join",
         data: {
          "community_id":communityId
        }
      );

      return JoinCommunityResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DioException(
        error: e.message,
        message: e.response?.data[0]["error"],
        requestOptions: RequestOptions(path: "community"),
      );
    }
  }

  Future<AllCommunityResponseModel> getAllCommunity() async {
    Dio dio = getDioInstance();
    try {
      final response = await dio.get(
        "community",
      );

      return AllCommunityResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DioException(
        error: e.message,
        message: e.response?.data[0]["error"],
        requestOptions: RequestOptions(path: "community"),
      );
    }
  }
}
