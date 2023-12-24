import 'package:dio/dio.dart';

import '../model/retweet_model.dart';
import '../../../core/utils/network_utils.dart';

class RetweetBlogsRepo {
  static Future<RetweetModel?> retweet(
    context, {
    required int? blogId,
  }) async {
    final util = NetworkUtil();

    var response = await util.post(
      'retweet',
      context: context,
      body: FormData.fromMap(
        {
          'blog_id': blogId,
        },
      ),
    );
    if (response == null) {
      return null;
    }
    var model = RetweetModel.fromJson(response.data);

    return model;
  }
}
