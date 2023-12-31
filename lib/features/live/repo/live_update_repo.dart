import 'dart:developer';

import 'package:creen/core/utils/laravel_exception.dart';
import 'package:creen/core/utils/network_utils.dart';
import 'package:dio/dio.dart';

class LiveUpdateRepo{
  static Future<void> updateLive({
    required Map<String,dynamic> body,
    // required int liveId,
    // required dynamic liveImage,
  }) async {
    final util = NetworkUtil();
    var url = 'live/update';

    log('url is $url');
    log('data is $body');
    var response = await util.post(
      url,
      body:FormData.fromMap(body),
    );

    if (response?.statusCode == 404 || (response?.statusCode ?? 0) >= 500) {
      throw LaravelException(
          'Something went wrong \nSTATUS_CODE: ${response?.statusCode}');
    }
    log('image updated response $response');
    if(response?.statusCode == 200) {

    }
    // return followers;

    /* try {
      var model = LiveModel.fromJson(response.data);
      // log(' live model ${model.data?[0].title}');
      return model;
    } catch (error) {
      throw LaravelException('Something went wrong \n ${error.toString()}');
    }*/
  }
}