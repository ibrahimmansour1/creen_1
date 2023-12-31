import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../core/utils/laravel_exception.dart';
import '../model/my_followers_model.dart';
import '../../../core/utils/network_utils.dart';

class MyFollowersRepo {
  static Future<MyFollowersModel?> getMyFollowers(
    context, {
    int? userId,
  }) async {
    final util = NetworkUtil();
    var map = {
      if (userId != null) ...{
        'user_id': userId,
      },
    };
    log('$map', name: 'followers_map');
    var response = await util.post(
      'followers/${userId == null ? 'my' : ''}followers',
      body: FormData.fromMap(
        map,
      ),
    );
    if (response == null) {
      return null;
    }

    if (response.statusCode == 404 || (response.statusCode ?? 0) >= 500) {
      throw LaravelException(
        'Something went wrong \nSTATUS_CODE:${response.statusCode}',
      );
    }
    try {
      var model = MyFollowersModel.fromJson(response.data);
      return model;
    } catch (error) {
      throw LaravelException(
        'Something went wrong \n${error.toString()}',
      );
    }
  }
}
