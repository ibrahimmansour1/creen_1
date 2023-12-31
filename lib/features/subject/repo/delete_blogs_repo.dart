import 'package:dio/dio.dart';

import '../model/delete_blogs_model.dart';
import '../../../core/utils/network_utils.dart';

class DeleteBlogsRepo {
  static Future<DeleteBlogModel?> delete(
    context, {
    required int? blogId,
  }) async {
    final util = NetworkUtil();

    var response = await util.post(
      'blogs/delete',
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
    var model = DeleteBlogModel.fromJson(response.data);

    return model;
  }
}
