import 'dart:developer';

import 'package:creen/core/utils/network_utils.dart';

class SocialLoginRepo {
  static Future<void> socialLogin({
    required String email,
    // required String email,
    required String? name,
     String? cover,
  }) async {

    final util = NetworkUtil();
    // log('body $body');

    var response = await util.post(
      'loginwithapi?email=$email&name=$name${cover!=null?'&cover=$cover':null}',

    );
    log('Social Login response ==> ${response?.data}');
/*    if (response == null) {
      return null;
    }
    var model = LoginModel.fromJson(response.data);

    return model;*/

  }
}
