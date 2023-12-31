import 'dart:developer';

import 'package:dio/dio.dart';

import '../model/retweet_model.dart';
import '../../../core/utils/network_utils.dart';

class UpdateSeenBlogsRepo {
  static Future</*RetweetModel?*/void> updateSeen(
      {
        required int? blogId,
      }) async {
    final util = NetworkUtil();

    var response = await util.post(
      'blogs/updateseen',
      body: FormData.fromMap(
        {
          'id': blogId,
        },
      ),
    );
    log('response ${response?.data}');
  /*  if (response == null) {
      return null;
    }
    var model = RetweetModel.fromJson(response.data);

    return model;*/
  }
}
