import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/widgets/k_button.dart';
import 'package:moury/core/services/network_services.dart';
import 'package:moury/core/services/toast_services.dart';
import 'package:moury/modules/data/all_users/model/all_users_response_model.dart';
import 'package:moury/modules/data/all_users/model/follow_response_model.dart';
import 'package:moury/modules/data/all_users/model/friend_request_response_model.dart';
import 'package:moury/modules/data/all_users/model/my_friends_response_model.dart';
import 'package:moury/modules/data/all_users/repository/get_all_user_repository.dart';
import 'package:moury/modules/data/base_model/base_model.dart';

class SingleUserProfileViewModel extends BaseModel {
  String userId;
  SingleUserProfileViewModel({
    required this.userId,
  });

  @override
  void onInit() {
    getSingleUser(userId);
    checkIsFriend(userId);
    super.onInit();
  }

  AllUsersResponseModel? userResponseModel;
  CheckFriendResponseModel? checkFriendResponseModel;
  MyFriendsResponseModel? myFriendsResponseModel;
  IGetAllUsersRepository singleUserRepo = GetAllUserRepository();
  FriendRequestResponseModel? friendRequestResponseModel;

  getSingleUser(String singleUserId) async {
    setLoading(true);
    var result = await singleUserRepo.getSingleUser(singleUserId);
    result.fold(
      (NetworkFailure error) {
        if (error.message?.isNotEmpty == true) {
          ToastService().e(error.message ?? '');
        } else {
          ToastService().e("An unknown error occurred");
        }
      },
      (AllUsersResponseModel data) async {
        userResponseModel = data;
        update();
      },
    );
    setLoading(false);
  }

  getMyFriends() async {
    setLoading(true);
    var result = await singleUserRepo.myFriends();
    result.fold(
      (NetworkFailure error) {
        if (error.message?.isNotEmpty == true) {
          ToastService().e(error.message ?? '');
        } else {
          ToastService().e("An unknown error occurred");
        }
      },
      (MyFriendsResponseModel data) async {
        myFriendsResponseModel = data;
        update();
      },
    );
    setLoading(false);
  }

  checkIsFriend(String singleUserId) async {
    setLoading(true);
    var result = await singleUserRepo.checkIsFriend(singleUserId);
    result.fold(
      (NetworkFailure error) {
        if (error.message?.isNotEmpty == true) {
          ToastService().e(error.message ?? '');
        } else {
          ToastService().e("An unknown error occurred");
        }
      },
      (CheckFriendResponseModel data) async {
        checkFriendResponseModel = data;
        update();
      },
    );
    setLoading(false);
  }

  addUser(String singleUserId) async {
    setLoading(true);
    var result = await singleUserRepo.addUser(singleUserId);
    result.fold(
      (NetworkFailure error) {
        if (error.message?.isNotEmpty == true) {
          ToastService().e(error.message ?? '');
        } else {
          ToastService().e("An unknown error occurred");
        }
      },
      (FriendRequestResponseModel data) async {
        ToastService().s(data.data ?? "Sucess!");
        friendRequestResponseModel = data;
        update();
      },
    );
    setLoading(false);
  }

  acceptUser(String singleUserId) async {
    setLoading(true);
    var result = await singleUserRepo.acceptUser(singleUserId);
    result.fold(
      (NetworkFailure error) {
        if (error.message?.isNotEmpty == true) {
          ToastService().e(error.message ?? '');
        } else {
          ToastService().e("An unknown error occurred");
        }
      },
      (FriendRequestResponseModel data) async {
        ToastService().s(data.data ?? "Sucess!");
        friendRequestResponseModel = data;
        update();
      },
    );
    setLoading(false);
  }

  deleteSentRequest(String singleUserId) async {
    setLoading(true);
    var result = await singleUserRepo.deleteSentRequest(singleUserId);
    result.fold(
      (NetworkFailure error) {
        if (error.message?.isNotEmpty == true) {
          ToastService().e(error.message ?? '');
        } else {
          ToastService().e("An unknown error occurred");
        }
      },
      (FriendRequestResponseModel data) async {
        ToastService().s(data.data ?? "Deleted sucessfully!");
        friendRequestResponseModel = data;
        update();
      },
    );
    setLoading(false);
  }

  rejectRequest(String singleUserId) async {
    setLoading(true);
    var result = await singleUserRepo.rejectRequest(singleUserId);
    result.fold(
      (NetworkFailure error) {
        if (error.message?.isNotEmpty == true) {
          ToastService().e(error.message ?? '');
        } else {
          ToastService().e("An unknown error occurred");
        }
      },
      (FriendRequestResponseModel data) async {
        ToastService().s(data.data ?? "Deleted sucessfully!");
        friendRequestResponseModel = data;
        update();
      },
    );
    setLoading(false);
  }

  KButton checkStatus(
      String status, String userid, String? userName, String? userImage) {
    if (checkFriendResponseModel?.areFriends == true) {
      return KButton(
        isBusy: isLoading,
        child: const Text("Message"),
        onPressed: () {
          Get.toNamed(
            '/single-chat',
            arguments: {
              'userId': userid,
              'username': userName,
              'userImage': userImage,
            },
          );
        },
      );
    }

    if (checkFriendResponseModel?.areFriends == false &&
        checkFriendResponseModel?.friendshipStatus == "nothing") {
      return KButton(
        isBusy: isLoading,
        child: const Text("Add friend"),
        onPressed: () async {
          await addUser(userid);
          await checkIsFriend(userid);
        },
      );
    }

    if (checkFriendResponseModel?.friendshipStatus == "pending") {
      return KButton(
        isBusy: isLoading,
        child: const Text("Cancel request"),
        onPressed: () async {
          await deleteSentRequest(userid);
          await checkIsFriend(userid);
        },
      );
    }

    if (checkFriendResponseModel?.friendshipStatus == "to_be_accepted") {
      return KButton(
        isBusy: isLoading,
        child: const Text("Confirm"),
        onPressed: () async {
          await acceptUser(userid);
          await checkIsFriend(userid);
        },
      );
    }

    return KButton(
        isBusy: isLoading, child: const Text("Go back"), onPressed: () {});
  }
}
