

import '../../../../core/services/network_services.dart';
import '../../../../core/services/toast_services.dart';
import '../../../data/base_model/base_model.dart';
import '../../../data/explore/models/explore_view_response_model.dart';
import '../../../data/explore/repository/explore_repository.dart';

class ExploreViewModel extends BaseModel {
  IExploreRepository? _exploreRepository;
  ExploreResponseModel? exploreResponseData;

  Future<void> getExplore() async {
    setLoading(true);
    var result = await _exploreRepository?.getExplore();
    result?.fold((NetworkFailure error) async {
      setError(error.message ?? '');
      ToastService().e(error.message ?? '');
    }, (ExploreResponseModel data) async {
      if (data.data?.isNotEmpty == true) {
        exploreResponseData = data;
    
      }
    });
    setLoading(false);
  }
}
