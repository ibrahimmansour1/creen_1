import 'package:creen/features/subject/model/delete_blogs_model.dart';
import 'package:dio/dio.dart';

import '../../../core/utils/network_utils.dart';

class DeleteAdRepo {
  static Future<DeleteBlogModel?> deleteAds({
    required int adId,
  }) async {
    final util = NetworkUtil();
    var response = await util.post(
      'promotions/delete',
      body: FormData.fromMap({
        'id': adId,
      }),
    );
    if (response == null) {
      return null;
    }
    var model = DeleteBlogModel.fromJson(response.data);

    return model;
  }
}
