import 'package:get/get.dart';
import 'package:moury/core/services/network_services.dart';
import 'package:moury/modules/data/base_model/base_model.dart';
import 'package:moury/modules/data/buzz_feed/models/buzz_feed_response_model.dart';
import '../../../../../core/services/toast_services.dart';
import '../../../../data/buzz_feed/repository/buzz_feed_repository.dart';

class BuzzFeedViewModels extends BaseModel {
  BuzzFeedResponseModel? buzzFeedData;
  IBuzzFeedRepository buzzFeedRepository = BuzzFeedRepository();

  void getBuzzFeed() async {
    setLoading(true);

    var result = await buzzFeedRepository.getBuzzFeed();
    result.fold(
      (NetworkFailure error) {
        if (error.message?.isNotEmpty == true) {
          ToastService().e(error.message ?? '');
        } else {
          ToastService().e("An unknown error occurred");
        }
      },
      (BuzzFeedResponseModel data) async {
        buzzFeedData = data;
        update();
      },
    );
    setLoading(false);
  }

  void createBuzz(String buzzComment) async {
    setLoading(true);

    var result = await buzzFeedRepository.createBuzz(buzzComment);
    result.fold(
      (NetworkFailure error) {
        if (error.message?.isNotEmpty == true) {
          ToastService().e(error.message ?? '');
        } else {
          ToastService().e("An unknown error occurred");
        }
      },
      (BuzzFeedResponseModel data) async {
        buzzFeedData = data;
        getBuzzFeed();
        Get.back();

        update();
      },
    );
    setLoading(false);
  }

  String calculateTimeAgo(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return '${difference.inSeconds} seconds ago';
    }
  }
}
