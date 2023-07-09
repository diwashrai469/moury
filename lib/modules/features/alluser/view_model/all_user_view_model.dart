import 'package:moury/modules/data/allusers/model/send_friend_request_response_model.dart';
import 'package:moury/modules/data/allusers/repository/get_all_user_repository.dart';
import 'package:moury/modules/data/common/base_model.dart';

import '../../../../core/services/network_services.dart';
import '../../../../core/services/toast_services.dart';
import '../../../data/allusers/model/all_users_response_model.dart';

class AllUserViewModel extends BaseModel {
  IGetAllUsersRepository getAllUserRepository = GetAllUserRepository();
  AllUsersResponseModel? allUsersResponseData;

  Future<void> getAllUser() async {
    setLoading(true);

    var result = await getAllUserRepository.getAllUser();
    result.fold(
      (NetworkFailure error) {
        if (error.message?.isNotEmpty == true) {
          ToastService().e(error.message ?? '');
        } else {
          ToastService().e("An unknown error occurred");
        }
      },
      (AllUsersResponseModel data) async {
        // final filterData=data.data.where((element) => element.sId !=)
        allUsersResponseData = data;
        update();
      },
    );
    setLoading(false);
  }

  Future<void> sendFriendRequest(String friendRequestId) async {
    var result = await getAllUserRepository.sendFriendRequest(friendRequestId);
    result.fold(
      (NetworkFailure error) {
        if (error.message?.isNotEmpty == true) {
          ToastService().e(error.message ?? '');
        } else {
          ToastService().e("An unknown error occurred");
        }
      },
      (SendFriendResonseModel data) async {
        ToastService().s(data.data ?? 'Sucess');
      },
    );
  }

 
  }


