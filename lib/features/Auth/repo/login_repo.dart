import 'dart:developer';

import 'package:dio/dio.dart';

import '../model/login_model.dart';
import '../../../core/utils/network_utils.dart';

class LoginRepo {
  static Future<LoginModel?> loginUser({
    required Map<String, dynamic> body,
  }) async {
    final util = NetworkUtil();
    log('body $body');

    var response = await util.post(
      'login',
      body: FormData.fromMap(body),
    );
    if (response == null) {
      return null;
    }
    var model = LoginModel.fromJson(response.data);

    return model;
  }
}
