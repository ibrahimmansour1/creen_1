import 'package:dio/dio.dart';

import '../model/add_blogs_to_fav_model.dart';
import '../../../core/utils/network_utils.dart';

class AddLikeToPostRepo {
  static Future<LikeBlogModel?> like(
    context, {
    required Map<String, dynamic> body,
  }) async {
    final util = NetworkUtil();

    var response = await util.post(
      'likes/create',
      body: FormData.fromMap(
        body,
      ),
    );
    if (response == null) {
      return null;
    }

    var model = LikeBlogModel.fromJson(response.data);

    return model;
  }
}
