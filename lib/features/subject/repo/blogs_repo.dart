import 'package:dio/dio.dart';

import '../model/blogs_model.dart';
import '../../../core/utils/network_utils.dart';

class BlogsRepo {
  static Future<BlogsModel?> getBlogs(
    context, {
    required int page,
    required int? userId,
  }) async {
    final util = NetworkUtil();

    bool isSpecificUserBlog = userId != null;

    var response = await util.post(
      'blogs${isSpecificUserBlog ? '/user' : ''}?page=$page',
      context: context,
      body: FormData.fromMap({
        if (isSpecificUserBlog) 'user_id': userId,
      }),
    );
    if (response == null) {
      return null;
    }
    var model = BlogsModel.fromJson(response.data);

    return model;
  }
}
