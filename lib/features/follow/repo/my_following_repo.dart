import 'package:dio/dio.dart';

import '../../../core/utils/laravel_exception.dart';
import '../model/my_following_model.dart';
import '../../../core/utils/network_utils.dart';

class MyFollowingRepo {
  static Future<MyFollowingModel?> getMyFollowing(
    context, {
    int? userId,
  }) async {
    final util = NetworkUtil();
    var response = await util.post(
      'followers/${userId == null ? 'my' : ''}following',
      body: FormData.fromMap(
        {
          if (userId != null) ...{
            'user_id': userId,
          },
        },
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
      var model = MyFollowingModel.fromJson(response.data);
      return model;
    } catch (error) {
      throw LaravelException(
        'Something went wrong \n${error.toString()}',
      );
    }
  }
}
