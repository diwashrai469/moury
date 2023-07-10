import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/common/widgets/k_button.dart';
import 'package:moury/core/services/network_services.dart';
import 'package:moury/core/services/toast_services.dart';
import 'package:moury/modules/data/all_users/model/all_users_response_model.dart';
import 'package:moury/modules/data/all_users/model/follow_response_model.dart';
import 'package:moury/modules/data/all_users/repository/get_all_user_repository.dart';
import 'package:moury/modules/data/base_model/base_model.dart';

class SingleUserProfileViewModel extends BaseModel {
  AllUsersResponseModel? userResponseModel;
  FollowResponseModel? followResponseData;
  IGetAllUsersRepository singleUserRepo = GetAllUserRepository();

  // Future<void> ollowUser(String singleUserId) async {
  //   setLoading(true);
  //   var result = await singleUserRepo.getSingleUser(singleUserId);
  //   result.fold(
  //     (NetworkFailure error) {
  //       if (error.message?.isNotEmpty == true) {
  //         ToastService().e(error.message ?? '');
  //       } else {
  //         ToastService().e("An unknown error occurred");
  //       }
  //     },
  //     (AllUsersResponseModel data) async {
  //       userResponseModel = data;
  //       update();
  //     },
  //   );
  //   setLoading(false);
  // }

  Future<void> getSingleUser(String singleUserId) async {
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

  Future<void> checkFollow(String singleUserId) async {
    setLoading(true);
    var result = await singleUserRepo.checkFollow(singleUserId);
    result.fold(
      (NetworkFailure error) {
        if (error.message?.isNotEmpty == true) {
          ToastService().e(error.message ?? '');
        } else {
          ToastService().e("An unknown error occurred");
        }
      },
      (FollowResponseModel data) async {
        followResponseData = data;
        update();
      },
    );
    setLoading(false);
  }

  Future<void> followUser(String singleUserId) async {
    setLoading(true);
    var result = await singleUserRepo.followUser(singleUserId);
    result.fold(
      (NetworkFailure error) {
        if (error.message?.isNotEmpty == true) {
          ToastService().e(error.message ?? '');
        } else {
          ToastService().e("An unknown error occurred");
        }
      },
      (FollowResponseModel data) async {
        ToastService().s(data.data ?? "Sucess!");
        followResponseData = data;
        update();
      },
    );
    setLoading(false);
  }

  Future<void> unFollowUser(String singleUserId) async {
    setLoading(true);
    var result = await singleUserRepo.unfollowUser(singleUserId);
    result.fold(
      (NetworkFailure error) {
        if (error.message?.isNotEmpty == true) {
          ToastService().e(error.message ?? '');
        } else {
          ToastService().e("An unknown error occurred");
        }
      },
      (FollowResponseModel data) async {
        ToastService().s(data.data ?? "Un-followed!");
        followResponseData = data;
        update();
      },
    );
    setLoading(false);
  }

  KButton checkStatus(String status, String userid, String? userName) {
    if (followResponseData?.status == "unknown") {
      return KButton(
        child: const Text("Follow"),
        onPressed: () async {
          await followUser(userid);
          await checkFollow(userid);
        },
      );
    }
    if (followResponseData?.status == "friends") {
      return KButton(
          child: const Text("Message"),
          onPressed: () {
            Get.toNamed(
              '/single-chat',
              arguments: {'userId': userid, 'username': userName},
            );
          });
    }

    if (followResponseData?.status == "only_me") {
      return KButton(
        child: const Text("Un-Follow"),
        onPressed: () async {
         await unFollowUser(userid);
         await checkFollow(userid);
        },
      );
    }
    if (followResponseData?.status == "only_them") {
      return KButton(
        child: const Text("Follow back"),
        onPressed: () async {
          await followUser(userid);
          await checkFollow(userid);
        },
      );
    }
    return KButton(child: const Text("Go back"), onPressed: () {});
  }
}
