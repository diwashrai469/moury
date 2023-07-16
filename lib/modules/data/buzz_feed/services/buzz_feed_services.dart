import 'package:dio/dio.dart';
import 'package:moury/modules/data/buzz_feed/models/buzz_feed_response_model.dart';

import '../../../../core/services/intercepters.dart';

class BuzzFeedService {
  Future<BuzzFeedResponseModel> getBuzzFeed() async {
    Dio dio = getDioInstance();

    final response = await dio.get(
      "buzz",
    );
    return BuzzFeedResponseModel.fromJson(response.data);
  }

  Future<BuzzFeedResponseModel> createBuzz(String buzzComment) async {
    Dio dio = getDioInstance();

    final response = await dio.post("buzz", data: {"caption": buzzComment});
    return BuzzFeedResponseModel.fromJson(response.data);
  }
}
