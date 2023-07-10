import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:moury/core/services/toast_services.dart';
import 'package:moury/modules/data/base_model/base_model.dart';
import 'package:moury/modules/data/my_community/model/community_reponse_firebase_model.dart';
import '../../../../../core/services/intercepters.dart';

class SingleCommunityViewModel extends BaseModel {
  final firestoreInstance = FirebaseFirestore.instance;
  String? userId = '';

  RxList<CommunityChatModelOfFirebase> chatList =
      <CommunityChatModelOfFirebase>[].obs;

  void sendMessage({required String id, required String message}) async {
    Dio dio = getDioInstance();
    try {
      await dio.post(
        "community/chat",
        data: {
          'community_id': id,
          'message': message,
        },
      );
    } catch (e) {
      ToastService().e("Somthing went wrong!");
    }
  }

  void getSingleCommunityChats(String communityId) {
    print(communityId);
    try {
      firestoreInstance
          .collection('/communitychats/$communityId/messages/')
          .orderBy("time", descending: true)
          .snapshots()
          .listen((event) {
        if (event.docs.isEmpty) {
          print('No documents found in the collection.');
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
