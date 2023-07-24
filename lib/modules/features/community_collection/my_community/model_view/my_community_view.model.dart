import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:moury/modules/data/base_model/base_model.dart';
import 'package:moury/modules/data/chat/my_community/model/all_community_response_from_firebase_model.dart';
import 'package:moury/modules/data/chat/my_community/model/community_reponse_firebase_model.dart';
import 'package:moury/modules/data/chat/my_community/model/create_community_view_model.dart';
import '../../../../../core/services/local_storage.dart';
import '../../../../../core/services/network_services.dart';
import '../../../../../core/services/toast_services.dart';
import '../../../../data/chat/my_community/model/my_community_response_model.dart';
import '../../../../data/chat/my_community/repository/my_community_repository.dart';

class MyCommunityViewModel extends BaseModel {
  @override
  void onInit() {
    // getMyCommunity();
    // communityData = communityDatas;

    // update();
    super.onInit();
  }

  IMyCommunityRepository communityRepo = MyCommunityRepository();

  List<Communities> communityDatas = [];

  List<Communities> communityData = [];
  RxList<AllCommunityChatListFromFirebaseModel>
      allCommunityChatListFromFirebaseModel =
      <AllCommunityChatListFromFirebaseModel>[].obs;

  final firestoreInstance = FirebaseFirestore.instance;

  List<CommunityChatModelOfFirebase> chatList = [];

  void onChangedFilter(String text) {
    // communityData = communityDatas
    //     .where((element) =>
    //         element.communityId?.name
    //             ?.toLowerCase()
    //             .contains(text.toLowerCase()) ??
    //         false)
    //     .toList();
    // update();
  }

  createCommunity(String name, String description) async {
    setLoading(true);

    var result = await communityRepo.createCommunity(
        description: description, name: name);
    result.fold(
      (NetworkFailure error) {
        ToastService().e("An unknown error occurred");
      },
      (CreateCommunityViewModel data) {
        ToastService().s(data.data ?? "Sucess");
        getMyCommunity();
        update();
        Get.back();
        Get.back();
      },
    );
    setLoading(false);
  }

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

  getAllCommunityChatListFromFirebase() {
    List<dynamic> communityids = [];
    final token = LocalStorageService().read(
      LocalStorageKeys.accessToken,
    );
    final decodedToken = JwtDecoder.decode(token.toString());

    String userId = decodedToken["_id"];

    // Query the 'mycommunities' collection to get the user's joined communities
    firestoreInstance
        .collection('/mycommunities/')
        .where("user_id", isEqualTo: userId)
        .snapshots()
        .listen(
      (myCommunitiesSnapshot) {
        communityids.clear(); // Clear the list before adding new IDs

        // Extract community IDs from the query result
        for (var data in myCommunitiesSnapshot.docs) {
          communityids.add(data["community_id"]);
        }

        // Query the 'communitychatslist' collection to fetch relevant results
        firestoreInstance
            .collection('/communitychatslist/')
            .where("community_id", whereIn: communityids)
            .orderBy("time", descending: true)
            .snapshots()
            .listen(
          (communityChatsSnapshot) {
            List<AllCommunityChatListFromFirebaseModel> tempList = [];

            // Extract data and create models from the query result
            for (var doc in communityChatsSnapshot.docs) {
              tempList.add(
                  AllCommunityChatListFromFirebaseModel.fromJson(doc.data()));
            }

            // Assign the data to the model list
            allCommunityChatListFromFirebaseModel.assignAll(tempList);
          },
        );
      },
    );
  }

  Future<void> getMyCommunity() async {
    setLoading(true);

    var result = await communityRepo.getMyCommunity();
    result.fold(
      (NetworkFailure error) {
        ToastService().e("An unknown error occurred");
      },
      (MyCommunityResponseModel data) {
        if (data.communities != null) {
          // communityDatas.assignAll(data.communities!);
          update();
        }
      },
    );

    setLoading(false);
  }
}
