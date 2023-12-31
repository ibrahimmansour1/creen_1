import 'dart:developer';

import '../../../core/utils/network_utils.dart';

class ResetPasswordRepo{
  static Future<void>resetPassword({required String email,required String code,required String password,}) async {
    final util = NetworkUtil();
    log( 'newpassword?email=$email&code=$code&password=$password');
    var response = await util.post(
        'newpassword?email=$email&code=$code&password=$password');

    log('newpassword response ==>${response?.data}');
    // var model = FollowModel.fromJson(response.data);

    // return model;

  }
}