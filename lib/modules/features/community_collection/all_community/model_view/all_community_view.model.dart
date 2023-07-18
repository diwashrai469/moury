import 'package:get/get.dart';
import 'package:moury/modules/data/all_community/models/all_community_response_model.dart';
import 'package:moury/modules/data/all_community/models/join_community.dart';
import 'package:moury/modules/data/base_model/base_model.dart';
import '../../../../../core/services/network_services.dart';
import '../../../../../core/services/toast_services.dart';
import '../../../../data/all_community/repository/all_community_repository.dart';
import '../../../../data/chat/my_community/model/leave_community_response_model.dart';
import '../../../../data/chat/my_community/model/my_community_response_model.dart';
import '../../../../data/chat/my_community/repository/my_community_repository.dart';

class AllCommunityViewModel extends BaseModel {
  var communityJoin = "".obs;

  alreadyJoined(String communityid) {
    bool isjoined = myCommunityDatas
        .any((element) => element.communityId!.sId!.contains(communityid));

    if (isjoined == true) {
      communityJoin.value = "Member";
    } else {
      communityJoin.value = "Join";
    }
  }

  IAllCommunityRepository allCommunityRepo = AllCommunityRepository();

  AllCommunityResponseModel? getAllCommunityData;
  AllCommunityResponseModel? getSingleCommunityData;

  JoinCommunityResponseModel? joinResponse;
  IMyCommunityRepository myCommunityRepository = MyCommunityRepository();
  List<Communities> myCommunityDatas = [];

  getAllCommunity() async {
    setLoading(true);

    var result = await allCommunityRepo.getAllCommunity();
    result.fold(
      (NetworkFailure error) {
        ToastService().e(error.message ?? "Unknown error occured!");
      },
      (AllCommunityResponseModel data) {
        getAllCommunityData = data;

        update();
      },
    );

    setLoading(false);
  }

  getSingleCommunity(String sid) async {
    setLoading(true);

    var result = await allCommunityRepo.getSingleCommunity(sid);
    result.fold(
      (NetworkFailure error) {
        ToastService().e(error.message ?? "Unknown error occured!");
      },
      (AllCommunityResponseModel data) {
        getSingleCommunityData = data;

        update();
      },
    );

    setLoading(false);
  }

  leaveCommunity({
    required String id,
  }) async {
    setLoading(true);

    var result = await myCommunityRepository.leaveCommmunity(
      id: id,
    );
    result.fold(
      (NetworkFailure error) {
        if (error.message?.isNotEmpty == true) {
          ToastService().e(error.message ?? '');
        } else {
          ToastService().e("An unknown error occurred");
        }
      },
      (LeaveCommunityResponseModel data) {
        ToastService().s(data.data ?? "Sucess");
      },
    );

    setLoading(false);
  }

  getMyCommunity() async {
    setLoading(true);

    var result = await myCommunityRepository.getMyCommunity();
    result.fold(
      (NetworkFailure error) {
        ToastService().e("An unknown error occurred");
      },
      (MyCommunityResponseModel data) {
        if (data.communities != null) {
          myCommunityDatas.assignAll(data.communities!);

          update();
        }
      },
    );

    setLoading(false);
  }

  joinCommunity(String communityId, String userName) async {
    var result = await allCommunityRepo.joinCommunity(communityId);
    result.fold(
      (NetworkFailure error) {
        ToastService().e(error.message ?? "unknow Error occured");
      },
      (JoinCommunityResponseModel data) async {
        joinResponse = data;
        ToastService().s(data.data.toString());
        await getMyCommunity();

        await alreadyJoined(communityId);
      

        update();
      },
    );
  }
}
