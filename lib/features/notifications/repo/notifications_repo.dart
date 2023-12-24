

import '../model/notification_model.dart';
import '../../../core/utils/network_utils.dart';

class NotificationsRepo {
  static Future<NotificationsModel?> getNotifications(
    context, {
    required int page,
  }) async {
    final util = NetworkUtil();

    var response = await util.get(
      'notifications?page=$page',
    );
    if (response == null) {
      return null;
    }

    var model = NotificationsModel.fromJson(response.data);

    return model;
  }
}
