import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:moury/core/services/toast_services.dart';
import 'package:moury/modules/data/base_model/base_model.dart';
import '../../../../../core/services/intercepters.dart';
import '../../../../../core/services/local_storage.dart';
import '../../../../data/chat/models/chat_view_response_model.dart';

class SingleChatViewModel extends BaseModel {
  final firestoreInstance = FirebaseFirestore.instance;
  String? userId = '';

  RxList<PrivateChatListResponseModel> chatList =
      <PrivateChatListResponseModel>[].obs;

  void sendMessage({required String id, required String message}) async {
    Dio dio = getDioInstance();
    print(id);
    print(message);
    try {
      await dio.post(
        "privatechat",
        data: {
          'to': id,
          'message': message,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print("somthing went wrong");
      }
    }
  }

  void getPrivateChats(String id) {
    final token = LocalStorageService().read(
      LocalStorageKeys.accessToken,
    );
    final decodedToken = JwtDecoder.decode(token.toString());

    var idStrings = [decodedToken["_id"], id];
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
