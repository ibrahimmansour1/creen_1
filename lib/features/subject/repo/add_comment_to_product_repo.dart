import 'package:dio/dio.dart';

import '../model/add_comment_to_product_model.dart';
import '../../../core/utils/network_utils.dart';

class AddCommentToPostRepo {
  static Future<AddCommentToProductModel?> addCommentToPost(
    context, {
    required Map<String, dynamic> body,
  }) async {
    final util = NetworkUtil();

    var response = await util.post(
      'products/comments/create',
      body: FormData.fromMap(
        body,
      ),
    );
    if (response == null) {
      return null;
    }

    var model = AddCommentToProductModel.fromJson(response.data);

    return model;
  }
}
