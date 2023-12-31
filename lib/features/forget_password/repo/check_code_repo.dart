import 'dart:developer';

import '../../../core/utils/network_utils.dart';

class CheckCodeRepo{
  static Future<void>checkCode({required String email,required String code,}) async {
    final util = NetworkUtil();
    log( 'check_code?email=$email&code=$code');
    var response = await util.post(
        'check_code?email=$email&code=$code');

    log('check_code response ==>${response?.data}');
    // var model = FollowModel.fromJson(response.data);

    // return model;

  }
}