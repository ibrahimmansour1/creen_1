import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../core/utils/laravel_exception.dart';
import '../../../core/utils/network_utils.dart';
import '../model/create_product_model.dart';

class CreateProductRepo {
  static Future<CreateProductModel?> createProducts({
    required Map<String, dynamic> body,
    required bool isEdit,
  }) async {
    final util = NetworkUtil();
    var url = 'products/${!isEdit ? 'create' : 'update'}';
    log('$body');
    var response = await util.post(
      url,
      body: FormData.fromMap(body),
    );

    if (response == null) {
      return null;
    }

    if (response.statusCode == 404 || (response.statusCode ?? 0) >= 500) {
      throw LaravelException(
          'Something went wrong \nSTATUS_CODE: ${response.statusCode}');
    }

    try {
      var model = CreateProductModel.fromJson(response.data);
      return model;
    } catch (error) {
      throw LaravelException('Something went wrong \n ${error.toString()}');
    }
  }
}
