import '../../../../core/services/network_services.dart';
import '../../../../core/services/toast_services.dart';
import '../../../data/all_community/models/all_community_response_model.dart';
import '../../../data/all_community/repository/all_community_repository.dart';
import '../../../data/base_model/base_model.dart';
import '../../../data/explore/models/explore_view_response_model.dart';
import '../../../data/explore/repository/explore_repository.dart';

class ExploreViewModel extends BaseModel {
  IExploreRepository? exploreRepository = ExploreRepository();
  IAllCommunityRepository allCommunityRepo = AllCommunityRepository();

  ExploreResponseModel? exploreResponseData;

  AllCommunityResponseModel? getAllCommunityData;

  int counts(int indexs) {
    if (indexs >= 8) {
      return 8;
    }
    if (indexs < 8) {
      return 7;
    }
    if (indexs < 7) {
      return 6;
    }
    if (indexs < 6) {
      return 5;
    }
    if (indexs < 5) {
      return 4;
    }
    if (indexs < 4) {
      return 3;
    }
    if (indexs < 3) {
      return 2;
    }
    if (indexs < 2) {
      return 1;
    }

    return 0;
  }

  getAllCommunity() async {
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

  getExplore() async {
    setLoading(true);
    var result = await exploreRepository?.getExplore();
    result?.fold((NetworkFailure error) async {
      setError(error.message ?? '');
      ToastService().e(error.message ?? '');
    }, (ExploreResponseModel data) async {
      exploreResponseData = data;
      print("exploredata:${exploreResponseData?.data?.first.name}");
      update();
    });
    setLoading(false);
  }
}
