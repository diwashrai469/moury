import 'package:dartz/dartz.dart';
import 'package:moury/core/services/network_services.dart';
import 'package:moury/modules/data/chat/private_chat/models/private_chat_view_response_model.dart';
import 'package:moury/modules/data/chat/private_chat/services/private_chat_services.dart';

abstract class IPrivateChatRepository {
  Future<Either<NetworkFailure, PrivateChatListResponseModel>> sendMessage(
      {required String id, required String message});
}

class ChatRepository extends IPrivateChatRepository {
  @override
  Future<Either<NetworkFailure, PrivateChatListResponseModel>> sendMessage({
   required String id, required String message
  }) async {
    try {
      var result =await PrivateChatServices().sendMessage(id: id, message: message);

      return Right(result);
    } on NetworkFailure catch (e) {
      return left(e);
    }
  }
}