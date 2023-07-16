import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:moury/modules/data/base_model/base_model.dart';

import '../../../../../core/services/local_storage.dart';
import '../../../../data/chat/private_chat/models/private_chat_view_response_model.dart';

class PrivateChatViewModel extends BaseModel {
  final firestoreInstance = FirebaseFirestore.instance;
  String? userId = '';

  RxList<PrivateChatListResponseModel> chatList =
      <PrivateChatListResponseModel>[].obs;

  // Getting the private chat list from the specified route
  void getPrivateChatList() {
    final token = LocalStorageService().read(
      LocalStorageKeys.accessToken,
    );
    final decodedToken = JwtDecoder.decode(token.toString());
    firestoreInstance
        .collection('/privatechatslist/${decodedToken["_id"]}/chatlist/')
        .orderBy("time", descending: true)
        .snapshots()
        .listen((event) {
      List<PrivateChatListResponseModel> tempList = [];
      userId = decodedToken['_id'];

      for (var doc in event.docs) {
        tempList.add(PrivateChatListResponseModel.fromJson(doc.data()));
      }
      chatList.assignAll(tempList);
      update();
    });
  }


}
