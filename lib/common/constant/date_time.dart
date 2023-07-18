import 'package:intl/intl.dart';

class ShowDateAndTimeInAgo {
  String convertToTimeAgo(int timestamp) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final difference = now - timestamp;
    final seconds = (difference / 1000).floor();
    final minutes = (difference / 60000).floor();
    final hours = (difference / 3600000).floor();
    final days = (difference / (3600000 * 24)).floor();

    if (days >= 1) {
      final format = NumberFormat('###,###');
      return '${format.format(days)} days';
    } else if (hours >= 1) {
      final format = NumberFormat('###,###');
      return '${format.format(hours)} hr';
    } else if (minutes >= 1) {
      final format = NumberFormat('###,###');
      return '${format.format(minutes)} min';
    } else if (seconds >= 1) {
      final format = NumberFormat('###,###');
      return '${format.format(seconds)} sec';
    } else {
      return 'now';
    }
  }
}
