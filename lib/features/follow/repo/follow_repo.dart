import 'dart:developer';

import 'package:dio/dio.dart';

import '../model/follow_model.dart';
import '../../../core/utils/network_utils.dart';

class FollowRepo {
  static Future<FollowModel?> follow(
     {
    required bool isFollow,
    required Map<String, dynamic> body,
  }) async {
    final util = NetworkUtil();
    log(
      'followers/${!isFollow ? 'follow' : 'unfollow'} body $body',
    );
    var response = await util.post(
      'followers/${!isFollow ? 'follow' : 'unfollow'}',
      body: FormData.fromMap(
        body,
      ),
    );
    if (response == null) {
      return null;
    }

    var model = FollowModel.fromJson(response.data);

    return model;
  }
}
