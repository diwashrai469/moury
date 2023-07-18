import 'package:dio/dio.dart';
import 'package:moury/modules/data/chat/my_community/model/create_community_view_model.dart';
import 'package:moury/modules/data/chat/my_community/model/my_community_response_model.dart';

import '../../../../../core/services/intercepters.dart';
import '../model/leave_community_response_model.dart';

class MyCommunityService {
  Future<MyCommunityResponseModel> getMyCommunity() async {
    Dio dio = getDioInstance();

    final response = await dio.get(
      "community/my",
    );

    return MyCommunityResponseModel.fromJson(response.data);
  }

  Future<LeaveCommunityResponseModel> leaveMyCommunity(String id) async {
    Dio dio = getDioInstance();

    final response = await dio.delete(
      "community/leave/$id",
    );

    return LeaveCommunityResponseModel.fromJson(response.data);
  }

  Future<CreateCommunityViewModel> createCommunity(
      String name, String description) async {
    Dio dio = getDioInstance();

    final response = await dio.post("community/create",
        data: {'name': name, 'description': description});

    return CreateCommunityViewModel.fromJson(response.data);
  }

  Future<MyCommunityResponseModel> sendMessage(
      {required String id, required String message}) async {
    Dio dio = getDioInstance();

    final response = await dio.post(
      "community/chat",
      data: {
        'community_id': id,
        'message': message,
      },
    );

    return MyCommunityResponseModel.fromJson(response.data);
  }
}
