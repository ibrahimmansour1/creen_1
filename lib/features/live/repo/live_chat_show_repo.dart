import 'dart:developer';

import 'package:creen/core/utils/laravel_exception.dart';
import 'package:creen/core/utils/network_utils.dart';

class LiveChatShowRepo{
  static Future<void> chatShow({
    required int liveId,
    required int creatorID,


  }) async {
    final util = NetworkUtil();
    var url =
        'live/chat/show?live_id=$liveId&creator_id=$creatorID';

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
    // return response.data['data']['likes'];
    log('comment store response ${response.data}');
    /* try {
      var model = LiveModel.fromJson(response.data);
      // log(' live model ${model.data?[0].title}');
      return model;
    } catch (error) {
      throw LaravelException('Something went wrong \n ${error.toString()}');
    }*/
  }
}