import 'package:dio/dio.dart';

import '../model/add_comment_to_post_model.dart';
import '../../../core/utils/network_utils.dart';

class AddCommentToPostRepo {
  static Future<AddCommentToPostModel?> addCommentToPost(
    context, {
    required Map<String, dynamic> body,
  }) async {
    final util = NetworkUtil();

    var response = await util.post(
      'comments/create',
      body: FormData.fromMap(
        body,
      ),
    );
    if (response == null) {
      return null;
    }

    var model = AddCommentToPostModel.fromJson(response.data);

    return model;
    
  }
}
