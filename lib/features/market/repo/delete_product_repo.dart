import 'package:creen/features/subject/model/delete_blogs_model.dart';
import 'package:dio/dio.dart';

import '../../../core/utils/network_utils.dart';

class DeleteProductRepo {
  static Future<DeleteBlogModel?> deleteProductById({
    required int? productId,
  }) async {
    final util = NetworkUtil();

    var response = await util.post(
      'products/delete',
      body: FormData.fromMap({
        'id': productId,
      }),
    );
    if (response == null) {
      return null;
    }
    var model = DeleteBlogModel.fromJson(response.data);

    return model;
  }
}
