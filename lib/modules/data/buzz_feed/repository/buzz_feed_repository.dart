import 'package:dartz/dartz.dart';
import 'package:moury/modules/data/buzz_feed/models/buzz_feed_response_model.dart';
import 'package:moury/modules/data/buzz_feed/services/buzz_feed_services.dart';

import '../../../../core/services/network_services.dart';

abstract class IBuzzFeedRepository {
  Future<Either<NetworkFailure, BuzzFeedResponseModel>> getBuzzFeed(
      );
       Future<Either<NetworkFailure, BuzzFeedResponseModel>> createBuzz(
        String buzzComment
        
      );
}

class BuzzFeedRepository extends IBuzzFeedRepository {
  @override
  Future<Either<NetworkFailure, BuzzFeedResponseModel>> getBuzzFeed(
   
   
  ) async {
    try {
      var result = await BuzzFeedService().getBuzzFeed();

      return Right(result);
    } on NetworkFailure catch (e) {
      return left(e);
    }
  }

    @override
  Future<Either<NetworkFailure, BuzzFeedResponseModel>> createBuzz(
     String buzzComment
   
  ) async {
    try {
      var result = await BuzzFeedService().createBuzz(buzzComment);

      return Right(result);
    } on NetworkFailure catch (e) {
      return left(e);
    }
  }
}
