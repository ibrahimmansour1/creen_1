

import 'dart:developer';

import 'package:dio/dio.dart';

import '../model/notification_model.dart';
import '../../../core/utils/network_utils.dart';

class NotificationDestroyRepo {
  static Future<void/*NotificationsModel?*/> destroyNotification(
       {
        required int id,
      }) async {
    final util = NetworkUtil();
log('map ${{
  'notification_id': id
}}');
    var response = await util.post(
      'notifications/destroy',
      body: FormData.fromMap({
        'notification_id': id
      })
    );
    log('destroy notification response ===> ${response?.data}');
/*    if (response == null) {
      return null;
    }

    var model = NotificationsModel.fromJson(response.data);

    return model;*/
  }
}
