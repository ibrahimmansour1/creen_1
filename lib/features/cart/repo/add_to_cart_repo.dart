import '../model/add_to_cart_model.dart';

import 'package:dio/dio.dart';

import '../../../core/utils/network_utils.dart';

class AddToCartRepo {
  static Future<AddToCartModel?> addToCart(
    context, {
    required Map<String, dynamic> body,
  }) async {
    final util = NetworkUtil();

    var response = await util.post(
      'carts/create',
      body: FormData.fromMap(
        body,
      ),
    );
    if (response == null) {
      return null;
    }

    var model = AddToCartModel.fromJson(response.data);

    return model;
  }
}
