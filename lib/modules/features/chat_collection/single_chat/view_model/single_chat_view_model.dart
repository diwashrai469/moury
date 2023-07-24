import 'dart:async';
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
  bool isSeen = false;

  IPrivateChatRepository chatRepository = ChatRepository();
  PrivateChatListResponseModel? privateChatList;
  List<String> documentKeyList = [];
  StreamSubscription<QuerySnapshot>? chatSubscription;
  RxList<PrivateChatListResponseModel> chatList =
      <PrivateChatListResponseModel>[].obs;
  final StreamController<List<PrivateChatListResponseModel>>
      _chatListStreamController =
      StreamController<List<PrivateChatListResponseModel>>.broadcast();

  Stream<List<PrivateChatListResponseModel>> get chatStream =>
      _chatListStreamController.stream;

  // @override
  // void onClose() {
  //   print("dispose is called");
  //   chatSubscription?.cancel();
  //   super.onClose();
  // }

  void sendMessage({required String id, required String message}) async {
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
  }

  void getPrivateChats(String nextPartyId) {
    final token = LocalStorageService().read(
      LocalStorageKeys.accessToken,
    );
    final decodedToken = JwtDecoder.decode(token.toString());

    userId = decodedToken["_id"];
    var idStrings = [userId, nextPartyId];
    idStrings.sort();
    var concatenatedId = idStrings.join("_");
    try {
      chatSubscription = firestoreInstance
          .collection('/privatechats/$concatenatedId/messages/')
          .orderBy("time", descending: true)
          .limit(40)
          .snapshots()
          .listen((event) {
        List<PrivateChatListResponseModel> tempList = [];

        for (var doc in event.docs) {
          tempList.add(PrivateChatListResponseModel.fromJson(doc.data()));
        }

        chatList.assignAll(tempList);
        updateDocument(nextPartyId, userId ?? '');

        _chatListStreamController.add(tempList);
      });
      // isTyping(id, userId ?? '');

      update();
    } catch (e) {
      ToastService().e("Somthing went wrong!");
    }
  }

  Future<void> isTyping(String nextPartyid, String myUserId) async {
    final firestore = FirebaseFirestore.instance;
    final documentRef = firestore
        .collection('privatechatslist')
        .doc(nextPartyid)
        .collection('chatlist')
        .doc(myUserId);

    try {
      DateTime currentDateTime = DateTime.now().toLocal();
      int currentTimestamp = currentDateTime.millisecondsSinceEpoch;
      await documentRef.update({'typing': currentTimestamp});
      print('Document successfully updated!');
    } catch (error) {
      print('Error updating document: $error');
    }
  }

  Future<void> updateDocument(String party1, String party2) async {
    final firestore = FirebaseFirestore.instance;
    final documentRef = firestore
        .collection('privatechatslist')
        .doc(party1)
        .collection('chatlist')
        .doc(party2);

    try {
      await documentRef.update({'seen': true});
      print('Document successfully updated!');
    } catch (error) {
      print('Error updating document: $error');
    }

    final documentRef2 = firestore
        .collection('privatechatslist')
        .doc(party2)
        .collection('chatlist')
        .doc(party1);

    try {
      await documentRef2.update({'seen_actual': true});
      print('Document successfully updated!');
    } catch (error) {
      print('Error updating document: $error');
    }
  }

  void getPrivateChatList(String nextPartyId) {
    final token = LocalStorageService().read(
      LocalStorageKeys.accessToken,
    );
    final decodedToken = JwtDecoder.decode(token.toString());

    firestoreInstance
        .collection('/privatechatslist/${decodedToken['_id']}/chatlist/')
        .where('receiver_sender_id', arrayContains: nextPartyId)
        .snapshots()
        .listen(
      (event) {
        for (var doc in event.docs) {
          privateChatList = PrivateChatListResponseModel.fromJson(doc.data());
          isSeen = privateChatList?.seen ?? false;
          update();
        }
      },
    );
  }

  //clear data
  void clearChatList() {
    chatList.clear();
    update();
  }
}
