import 'package:dio/dio.dart';

import '../model/create_blogs_model.dart';
import '../../../core/utils/laravel_exception.dart';
import '../../../core/utils/network_utils.dart';

class CreateNewBlogRepo {
  static Future<CreateBlogModel?> createBlog({
    required Map<String, dynamic> body,
    required bool isEdit,
  }) async {
    final util = NetworkUtil();

    var response = await util.post(
      'blogs/${isEdit ? 'update' : 'create'}',
      body: FormData.fromMap(body),
    );
    if (response == null) {
      return null;
    }

    if (response.statusCode == 404 || (response.statusCode ?? 0) >= 500) {
      throw LaravelException(
          'Something wrong \nSTATUS_CODE: ${response.statusCode}');
    }
// print("response data runtime ======> ${response.data["message"].runtimeType == String}");
    try {
      var model = CreateBlogModel.fromJson(response.data);
      return model;
    } on LaravelException catch (error) {
      throw LaravelException('Something wrong \n${error.toString()}');
    }
  }
}
