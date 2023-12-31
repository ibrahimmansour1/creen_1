import 'dart:developer';

import 'package:creen/core/utils/network_utils.dart';

class NotificationDestroyAllRepo {
  static Future<void/*NotificationsModel?*/> destroyAllNotifications(
      ) async {
    final util = NetworkUtil();

    var response = await util.post(
        'notifications/destroyall',

    );
    log('destroy notification response ===> ${response?.data}');
/*    if (response == null) {
      return null;
    }

    var model = NotificationsModel.fromJson(response.data);

    return model;*/
  }
}
