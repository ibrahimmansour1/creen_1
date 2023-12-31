import 'dart:developer';

import 'package:creen/core/utils/laravel_exception.dart';
import 'package:creen/core/utils/network_utils.dart';

class LiveCheckUserRepo{
  static Future<bool?> checkUser() async {
    final util = NetworkUtil();
    var url =
        'live/checkuser';

    log('url is $url');
    // log('data is $body');
    var response = await util.post(
      url,
      // body:FormData.fromMap(body),
    );

    if (response == null) {
      return null;
    }
    if (response.statusCode == 404 || (response.statusCode ?? 0) >= 500) {
      throw LaravelException(
          'Something went wrong \nSTATUS_CODE: ${response.statusCode}');
    }

     try {

      return response.data['data'];
    } catch (error) {
      throw LaravelException('Something went wrong \n ${error.toString()}');
    }
  }
}