import 'package:dio/dio.dart';

import '../model/create_blogs_model.dart';
import '../../../core/utils/laravel_exception.dart';
import '../../../core/utils/network_utils.dart';

class BlogDetailsRepo {
  static Future<CreateBlogModel?> getBlogDetails({
    required int? blogId,
  }) async {
    final util = NetworkUtil();

    var response = await util.post(
      'blogs/view',
      body: FormData.fromMap({
        'id': blogId,
      }),
    );
    if (response == null) {
      return null;
    }

    if (response.statusCode == 404 || (response.statusCode ?? 0) >= 500) {
      throw LaravelException(
          'Something wrong \nSTATUS_CODE: ${response.statusCode}');
    }

    try {
      var model = CreateBlogModel.fromJson(response.data);
      return model;
    } on LaravelException catch (error) {
      throw LaravelException('Something wrong \n${error.toString()}');
    }
  }
}
