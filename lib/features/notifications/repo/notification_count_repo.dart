import '../model/notification_count_model.dart';
import '../../../core/utils/network_utils.dart';

class NotificationsCountRepo {
  static Future<NotificationCountModel?> getNotificationsCount() async {
    final util = NetworkUtil();
    var response = await util.get(
      'notifications/count',
    );
    if (response == null) {
      return null;
    }
    var model = NotificationCountModel.fromJson(response.data);

    return model;
  }
}
