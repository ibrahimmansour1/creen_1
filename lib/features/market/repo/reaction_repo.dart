import 'package:dio/dio.dart';

import '../../../core/utils/laravel_exception.dart';
import '../model/like_model.dart';
import '../../../core/utils/network_utils.dart';

class ReactionRepo {
  static Future<ReactionModel?> react({
    required bool isLike,
    int? productId,
  }) async {
    final util = NetworkUtil();
    var response = await util.post('products/${!isLike ? '' : 'un'}like',
        body: FormData.fromMap({
          'product_id': productId,
        }));
    if (response == null) {
      return null;
    }

    if (response.statusCode == 404 || (response.statusCode ?? 0) >= 500) {
      throw LaravelException(
          'Something went wrong \nSTATUS_CODE: ${response.statusCode}');
    }

    try {
      var model = ReactionModel.fromJson(response.data);
      return model;
    } catch (error) {
      throw LaravelException('Something went wrong \n ${error.toString()}');
    }
  }
}
