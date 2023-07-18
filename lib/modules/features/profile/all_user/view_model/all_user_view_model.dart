import 'package:moury/modules/data/all_users/model/send_friend_request_response_model.dart';
import 'package:moury/modules/data/all_users/repository/get_all_user_repository.dart';
import 'package:moury/modules/data/base_model/base_model.dart';
import '../../../../../core/services/network_services.dart';
import '../../../../../core/services/toast_services.dart';
import '../../../../data/all_users/model/all_users_response_model.dart';

class AllUserViewModel extends BaseModel {
  
  @override
  void onInit() {
    getAllUser();
    super.onInit();
  }

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
