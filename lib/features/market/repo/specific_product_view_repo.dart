import 'package:dio/dio.dart';

import '../model/specific_product_model.dart';
import '../../../core/utils/laravel_exception.dart';
import '../../../core/utils/network_utils.dart';

class SpecificProductRepo {
  static Future<SpecificProductModel?> viewProduct({
     int? productId,
  }) async {
    final util = NetworkUtil();

    var response = await util.post(
      'products/view',
      body: FormData.fromMap(
        {
          'product_id': productId,
        },
      ),
    );

    if (response == null) {
      return null;
    }

    if (response.statusCode == 404 || (response.statusCode ?? 0) >= 500) {
      throw LaravelException(
          'Something went wrong \nSTATUS_CODE: ${response.statusCode}');
    }

    try {
      var model = SpecificProductModel.fromJson(response.data);
      return model;
    } catch (error) {
      throw LaravelException('Something went wrong \n ${error.toString()}');
    }
  }
}
