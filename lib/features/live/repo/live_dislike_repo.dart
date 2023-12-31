import 'dart:developer';

import 'package:creen/core/utils/laravel_exception.dart';
import 'package:creen/core/utils/network_utils.dart';

class LiveDisLikeRepo {
  // LiveModel?
  static Future<int?> disLikeLive({
    required int liveId,

  }) async {
    final util = NetworkUtil();
    var url =
        'live/dislike?id=$liveId';

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
 return response.data['data']['likes'];

    /* try {
      var model = LiveModel.fromJson(response.data);
      // log(' live model ${model.data?[0].title}');
      return model;
    } catch (error) {
      throw LaravelException('Something went wrong \n ${error.toString()}');
    }*/
  }
}
