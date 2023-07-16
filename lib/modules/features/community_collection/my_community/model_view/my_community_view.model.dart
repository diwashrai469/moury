import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';
import 'package:moury/modules/data/base_model/base_model.dart';
import 'package:moury/modules/data/chat/my_community/model/community_reponse_firebase_model.dart';
import '../../../../../core/services/network_services.dart';
import '../../../../../core/services/toast_services.dart';
import '../../../../data/chat/my_community/model/my_community_response_model.dart';
import '../../../../data/chat/my_community/repository/my_community_repository.dart';

class MyCommunityViewModel extends BaseModel {
  IMyCommunityRepository communityRepo = MyCommunityRepository();

  MyCommunityResponseModel? communityData;

  final firestoreInstance = FirebaseFirestore.instance;

  

  RxList<CommunityChatModelOfFirebase> chatList =
      <CommunityChatModelOfFirebase>[].obs;

  // Getting the private chat list from the specified route
  void getCommunityChats(String communityId) {
    firestoreInstance
        .collection('/communitychats/$communityId/messages/')
        .orderBy("time", descending: true)
        .snapshots()
        .listen((event) {
      List<CommunityChatModelOfFirebase> tempList = [];

      for (var doc in event.docs) {
        tempList.add(CommunityChatModelOfFirebase.fromJson(doc.data()));
      }
      chatList.assignAll(tempList);
      update();
    });
  }

  Future<void> getMyCommunity() async {
    setLoading(true);

    var result = await communityRepo.getMyCommunity();
    result.fold(
      (NetworkFailure error) {
        ToastService().e("An unknown error occurred");
      },
      (MyCommunityResponseModel data) {
        communityData = data; // Append data to the existing list
        update();
      },
    );

    setLoading(false);
  }
}
