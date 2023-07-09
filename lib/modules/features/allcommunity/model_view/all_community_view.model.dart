import 'package:get/get.dart';
import 'package:moury/modules/data/allcommunity/models/all_community_response_model.dart';
import 'package:moury/modules/data/allcommunity/models/join_community.dart';
import 'package:moury/modules/data/common/base_model.dart';
import '../../../../core/services/network_services.dart';
import '../../../../core/services/toast_services.dart';
import '../../../data/allcommunity/repository/all_community_repository.dart';

class AllCommunityViewModel extends BaseModel {
  IAllCommunityRepository allCommunityRepo = AllCommunityRepository();

  AllCommunityResponseModel? getAllCommunityData;

  JoinCommunityResponseModel? joinResponse;

  Future<void> getAllCommunity() async {
    setLoading(true);

    var result = await allCommunityRepo.getAllCommunity();
    result.fold(
      (NetworkFailure error) {
        ToastService().e("An unknown error occurred");
      },
      (AllCommunityResponseModel data) {
        getAllCommunityData = data;
        update();
      },
    );

    setLoading(false);
  }

  Future<void> joinCommunity(String communityId, String userName) async {
    var result = await allCommunityRepo.joinCommunity(communityId);
    result.fold(
      (NetworkFailure error) {
        ToastService().e("An unknown error occurred");
      },
      (JoinCommunityResponseModel data) {
        joinResponse = data;
        ToastService().s(data.data.toString());
        update();
        Get.toNamed('/single-community', arguments: {
          'communityId': communityId,
          'username': userName,
        });
      },
    );
  }
}
