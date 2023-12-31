import 'package:dio/dio.dart';

import '../../../core/utils/network_utils.dart';
import '../model/delete_comment_from_post_model.dart';

class DeleteCommentFromPostRepo {
  static Future<DeleteCommentFromPostModel?> deleteCommentFromPost(
      context, {
int? commentId      }) async {
    final util = NetworkUtil();

    var response = await util.post(
      'comments/delete',
      body: FormData.fromMap(
        {
          "comment_id":commentId
        },
      ),
    );
    if (response == null) {
      return null;
    }

    var model = DeleteCommentFromPostModel.fromJson(response.data);

    return model;

  }
}
