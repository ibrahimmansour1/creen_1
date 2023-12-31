import 'dart:developer';

import 'package:creen/core/utils/laravel_exception.dart';
import 'package:creen/core/utils/network_utils.dart';
import 'package:creen/features/live/model/live_model.dart';


class LiveRepo {
  // LiveModel?
  static Future<LiveModel?> getLive() async {
    final util = NetworkUtil();

    var url =
       'live';

    log('url is $url');
    var response = await util.post(
      url,
    );

    if (response == null) {
      return null;
    }

    if (response.statusCode == 404 || (response.statusCode ?? 0) >= 500) {
      throw LaravelException(
          'Something went wrong \nSTATUS_CODE: ${response.statusCode}');
    }

    try {
      var model = LiveModel.fromJson(response.data);
      // log(' live model ${model.data?[0].title}');
      return model;
    } catch (error) {
      throw LaravelException('Something went wrong \n ${error.toString()}');
    }
  }
}
