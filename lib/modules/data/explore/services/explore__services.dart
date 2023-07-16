import 'package:dio/dio.dart';
import 'package:moury/modules/data/explore/models/explore_view_response_model.dart';
import '../../../../core/services/intercepters.dart';

class ExploreService {
  Future<ExploreResponseModel> getExplores() async {
    Dio dio = getDioInstance();

    final response = await dio.get(
      "explore/friendSuggestions",
    );
    return ExploreResponseModel.fromJson(response.data);
  }
}
