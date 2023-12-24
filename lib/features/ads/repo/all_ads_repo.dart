import 'dart:developer';

import 'package:dio/dio.dart';

import '../model/my_ads_model.dart';
import '../../../core/utils/network_utils.dart';

class AllAdsRepo {
  static Future<MyAdsModel?> getAllAds({
    required int? userId,
    required int? categoryId,
  }) async {
    final util = NetworkUtil();
    var map = {
      if (userId != null) ...{
        'user_id': userId,
      },
      if (categoryId != null) ...{
        'category_id': categoryId,
      },
    };
    log(
      '$map',
      name: 'map_json',
    );
    var response = await util.post(
        'promotions${userId != null ? '/user' : categoryId != null ? '/category' : ''}',
        body: FormData.fromMap(map));
    if (response == null) {
      return null;
    }
    var model = MyAdsModel.fromJson(response.data);

    return model;
  }
}
