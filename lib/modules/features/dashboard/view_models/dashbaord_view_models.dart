import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:moury/modules/data/base_model/base_model.dart';

import '../../../../core/services/local_storage.dart';
import '../../../data/chat/private_chat/models/private_chat_view_response_model.dart';

class DashboardViewModel extends BaseModel {
  RxInt selectedIndex = 0.obs;
  RxBool hasNewMessage = false.obs;
  PageController pageController = PageController();
  final firestoreInstance = FirebaseFirestore.instance;
  List<PrivateChatListResponseModel> privateChatList = [];

  @override
  void onInit() {
    super.onInit();

    pageController = PageController(initialPage: selectedIndex.value);
  }

  void changeSelectedIndex(int newSelectedIndex) {
    selectedIndex.value = newSelectedIndex;
    pageController.jumpToPage(newSelectedIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void getPrivateChatList() {
    setLoading(true);
    final token = LocalStorageService().read(
      LocalStorageKeys.accessToken,
    );
    final decodedToken = JwtDecoder.decode(token.toString());
    firestoreInstance
        .collection('/privatechatslist/${decodedToken["_id"]}/chatlist/')
        .orderBy("time", descending: true)
        .snapshots()
        .listen(
      (event) {
        List<PrivateChatListResponseModel> tempList = [];

        for (var doc in event.docs) {
          tempList.add(PrivateChatListResponseModel.fromJson(doc.data()));
        }
        privateChatList.assignAll(tempList);
        int newMessages = 0;
        for (var data in privateChatList) {
          hasNewMessage.value = data.seen_actual ?? false;
          if (data.seen_actual == false) {
            newMessages++;
          }
        }
        hasNewMessage.value = newMessages > 0;

        update();
      },
    );
    setLoading(false);
  }
}
