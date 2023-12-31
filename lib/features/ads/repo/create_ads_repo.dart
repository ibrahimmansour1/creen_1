import 'dart:developer';

import 'package:dio/dio.dart';

import '../model/create_ad_model.dart';
import '../../../core/utils/network_utils.dart';

class CreateAdRepo {
  static Future<CreateAdsModel?> createAds({
    required Map<String, dynamic> body,
    required bool isEdit,
  }) async {
    final util = NetworkUtil();
    log(
      '$body',
      name: 'create_ad_body',
    );
    var response = await util.post(
      'promotions/${isEdit ? 'update' : 'create'}',
      body: FormData.fromMap(body),
    );
    if (response == null) {
      return null;
    }
    var model = CreateAdsModel.fromJson(response.data);

    return model;
  }
}
