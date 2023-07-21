import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:moury/modules/data/all_users/model/my_friends_response_model.dart';
import 'package:moury/modules/data/all_users/repository/get_all_user_repository.dart';
import 'package:moury/modules/data/base_model/base_model.dart';
import '../../../../../core/services/local_storage.dart';
import '../../../../../core/services/network_services.dart';
import '../../../../../core/services/toast_services.dart';
import '../../../../data/chat/private_chat/models/private_chat_view_response_model.dart';

class PrivateChatViewModel extends BaseModel {
  @override
  void onInit() {
    chatList = privateChatList;
    update();
    super.onInit();
    getMyFriends();
  }

  final firestoreInstance = FirebaseFirestore.instance;
  String? userId = '';
  List<PrivateChatListResponseModel> privateChatList = [];

  IGetAllUsersRepository allUsersRepository = GetAllUserRepository();
  List<String> documentKeyList = [];

  List<PrivateChatListResponseModel> chatList = [];
  MyFriendsResponseModel? myFriendsResponseModel;

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
        for (QueryDocumentSnapshot docSnapshot in event.docs) {
          documentKeyList.add(docSnapshot.id);
        }
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

  // Future<void> updateDocument(String nextPartyid, String myUserId) async {
  //   final firestore = FirebaseFirestore.instance;
  //   final documentRef = firestore
  //       .collection('privatechatslist')
  //       .doc(nextPartyid)
  //       .collection('chatlist')
  //       .doc(myUserId);

  //   try {
  //     await documentRef.update({'seen': true});
  //     print('Document successfully updated!');
  //   } catch (error) {
  //     print('Error updating document: $error');
  //   }
  // }

  void getMyFriends() async {
    setLoading(true);

    var result = await allUsersRepository.myFriends();
    result.fold(
      (NetworkFailure error) {
        if (error.message?.isNotEmpty == true) {
          ToastService().e(error.message ?? '');
        } else {
          ToastService().e("An unknown error occurred");
        }
      },
      (MyFriendsResponseModel data) {
        myFriendsResponseModel = data;
      },
    );
    setLoading(false);
  }
}
