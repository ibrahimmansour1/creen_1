import 'package:dio/dio.dart';

import '../../../core/utils/network_utils.dart';
import '../model/view_promotion_model.dart';

class ViewPromotionRepo {
  static Future<ViewPromotionModel?> viewPromotion({
    required int? promotionId,
  }) async {
    final util = NetworkUtil();
    var response = await util.post(
      'promotions/view',
      body: FormData.fromMap({
        'promotion_id': promotionId,
      }),
    );
    if (response == null) {
      return null;
    }
    var model = ViewPromotionModel.fromJson(response.data);

    return model;
  }
}
