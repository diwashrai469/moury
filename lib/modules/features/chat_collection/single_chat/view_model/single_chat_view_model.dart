import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:moury/core/services/toast_services.dart';
import 'package:moury/modules/data/base_model/base_model.dart';
import 'package:moury/modules/data/chat/private_chat/repository/private_chat_repository.dart';

import '../../../../../core/services/local_storage.dart';
import '../../../../../core/services/network_services.dart';
import '../../../../data/chat/private_chat/models/private_chat_view_response_model.dart';

class SingleChatViewModel extends BaseModel {
  final firestoreInstance = FirebaseFirestore.instance;
  String? userId = '';
  IPrivateChatRepository chatRepository = ChatRepository();

  RxList<PrivateChatListResponseModel> chatList =
      <PrivateChatListResponseModel>[].obs;

  void sendMessage({required String id, required String message}) async {
    setLoading(true);

    var result = await chatRepository.sendMessage(id: id, message: message);
    result.fold(
      (NetworkFailure error) {
        if (error.message?.isNotEmpty == true) {
          ToastService().e(error.message ?? '');
        } else {
          ToastService().e("An unknown error occurred");
        }
      },
      (PrivateChatListResponseModel data) async {},
    );
    setLoading(false);
  }

  void getPrivateChats(String id) {
    final token = LocalStorageService().read(
      LocalStorageKeys.accessToken,
    );
    final decodedToken = JwtDecoder.decode(token.toString());

    var idStrings = [decodedToken["_id"], id];
    userId = decodedToken["_id"];
    idStrings.sort();
    var concatenatedId = idStrings.join("_");
    try {
      firestoreInstance
          .collection('/privatechats/$concatenatedId/messages/')
          .orderBy("time", descending: true)
          .snapshots()
          .listen((event) {
        List<PrivateChatListResponseModel> tempList = [];

        for (var doc in event.docs) {
          tempList.add(PrivateChatListResponseModel.fromJson(doc.data()));
        }

        chatList.assignAll(tempList);

        update();
      });
    } catch (e) {
      ToastService().e("Somthing went wrong!");
    }
  }

  //clear data
  void clearChatList() {
    chatList.clear();
    update();
  }
}
