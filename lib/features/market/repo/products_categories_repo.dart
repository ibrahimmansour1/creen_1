import 'dart:developer';


import '../model/products_categories_model.dart';
import '../../../core/utils/laravel_exception.dart';
import '../../../core/utils/network_utils.dart';

class ProductsCategoriesRepo {
  static Future<ProductCategoriesModel?> getProductsCategories({
    required int page,
  }) async {
    final util = NetworkUtil();

    var url = 'products/categories?page=$page';
    log('url is $url');
    var response = await util.post(
      url,
    );

    if (response == null) {
      return null;
    }

    if (response.statusCode == 404 || (response.statusCode ?? 0) >= 500) {
      throw LaravelException(
          'Something went wrong \nSTATUS_CODE: ${response.statusCode}');
    }

    try {
      var model = ProductCategoriesModel.fromJson(response.data);
      return model;
    } catch (error) {
      throw LaravelException('Something went wrong \n ${error.toString()}');
    }
  }
}
