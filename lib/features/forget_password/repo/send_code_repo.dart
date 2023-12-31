import 'dart:developer';

import 'package:creen/core/utils/network_utils.dart';

class SendCodeRepo{
  static Future<void> sendCode({required String email})async {
    final util = NetworkUtil();
    log( 'forget?email=$email');
    var response = await util.post(
      'forget?email=$email');

log('forget response ==>${response?.data}');
    // var model = FollowModel.fromJson(response.data);

    // return model;
  }
}