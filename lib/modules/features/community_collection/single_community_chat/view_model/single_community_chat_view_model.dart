import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:moury/core/services/toast_services.dart';
import 'package:moury/modules/data/base_model/base_model.dart';
import 'package:moury/modules/data/chat/my_community/model/community_reponse_firebase_model.dart';
import 'package:moury/modules/data/chat/my_community/model/leave_community_response_model.dart';
import 'package:moury/modules/data/chat/my_community/model/my_community_response_model.dart';
import 'package:moury/modules/data/chat/my_community/repository/my_community_repository.dart';
import '../../../../../core/services/network_services.dart';
import '../../../../data/all_community/models/all_community_response_model.dart';
import '../../../../data/all_community/repository/all_community_repository.dart';

class SingleCommunityChatViewModel extends BaseModel {
  @override
  void onInit() {
    getAllCommunity();
    super.onInit();
  }

  final firestoreInstance = FirebaseFirestore.instance;
  String? userId = '';

  RxList<CommunityChatModelOfFirebase> chatList =
      <CommunityChatModelOfFirebase>[].obs;

  IMyCommunityRepository myCommunityRepository = MyCommunityRepository();
  IAllCommunityRepository allCommunityRepo = AllCommunityRepository();

  AllCommunityResponseModel? getAllCommunityData;

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
  }

  void sendMessage({required String id, required String message}) async {
    setLoading(true);

    var result =
        await myCommunityRepository.sendMessage(id: id, message: message);
    result.fold(
      (NetworkFailure error) {
        ToastService().e("An unknown error occurred");
      },
      (MyCommunityResponseModel data) {},
    );

    setLoading(false);
  }

  void leaveCommunity({
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

        // myCommunityRepository.getMyCommunity();
      },
    );

    setLoading(false);
  }

  void getSingleCommunityChats(String communityId) {
    try {
      firestoreInstance
          .collection('/communitychats/$communityId/messages/')
          .orderBy("time", descending: true)
          .snapshots()
          .listen((event) {
        if (event.docs.isEmpty) {
        } else {
          List<CommunityChatModelOfFirebase> tempList = [];

          for (var doc in event.docs) {
            tempList.add(CommunityChatModelOfFirebase.fromJson(doc.data()));
          }

          chatList.assignAll(tempList);
          update();
        }
      }, onError: (error) {
        print('Error fetching data: $error');
      });
    } catch (e) {
      ToastService().e("Something went wrong!");
    }
  }

  //clear data
  void clearChatList() {
    chatList.clear();
    update();
  }
}
