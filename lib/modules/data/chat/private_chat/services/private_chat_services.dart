import 'package:dio/dio.dart';
import 'package:moury/modules/data/chat/private_chat/models/private_chat_view_response_model.dart';
import '../../../../../core/services/intercepters.dart';

class PrivateChatServices {
  Future<PrivateChatListResponseModel> sendMessage(
      {required String id, required String message}) async {
    Dio dio = getDioInstance();

    final response = await dio.post(
      "privatechat",
      data: {
        'to': id,
        'message': message,
      },
    );
    return PrivateChatListResponseModel.fromJson(response.data);
  }

 
}
