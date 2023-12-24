import 'dart:developer';

import 'package:dio/dio.dart';

import '../model/all_products_model.dart';
import '../../../core/utils/laravel_exception.dart';
import '../../../core/utils/network_utils.dart';

class AllProductsRepo {
  static Future<AllProductsModel?> getProducts({
    required int page,
    String? productsSection,
    int? categoryId,
    int? userId,
  }) async {
    final util = NetworkUtil();
    var isSpecificUserProducts = userId != null;

    var url =
        'products${isSpecificUserProducts ? '/my_products' : productsSection == null ? '' : '/$productsSection'}?page=$page';
    var map = {
      if (categoryId != null) ...{
        'category_id': categoryId,
      },
      if (userId != null) ...{
        'user_id': userId,
      }
    };
    log('url is $url map $map');
    var response = await util.post(
      url,
      body: FormData.fromMap(
        map,
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
      var model = AllProductsModel.fromJson(response.data);
      return model;
    } catch (error) {
      throw LaravelException('Something went wrong \n ${error.toString()}');
    }
  }
}
