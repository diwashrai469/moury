import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:moury/modules/data/base_model/base_model.dart';
import '../../../../../core/services/local_storage.dart';
import '../../../../data/chat/private_chat/models/private_chat_view_response_model.dart';

class PrivateChatViewModel extends BaseModel {
  @override
  void onInit() {
    getPrivateChatList();
    chatList = privateChatList;
    update();
    super.onInit();
  }

  final firestoreInstance = FirebaseFirestore.instance;
  String? userId = '';
  List<PrivateChatListResponseModel> privateChatList = [];

  List<PrivateChatListResponseModel> chatList = [];

  void onChangedFilter(String filter) {
    chatList = privateChatList.where((chatItem) {
      String name = '';
      if (chatItem.senderId == userId) {
        name = chatItem.receiverDetails?.receiverUsername ?? '';
      } else {
        name = chatItem.senderDetails?.senderUsername ?? '';
      }
      return name.toLowerCase().contains(filter.toLowerCase());
    }).toList();

    update();
  }

  // Getting the private chat list from the specified route
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
        userId = decodedToken['_id'];

        for (var doc in event.docs) {
          tempList.add(PrivateChatListResponseModel.fromJson(doc.data()));
        }
        privateChatList.assignAll(tempList);
        update();
      },
    );
    setLoading(false);
  }
}
