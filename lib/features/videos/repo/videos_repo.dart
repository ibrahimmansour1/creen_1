import 'package:dio/dio.dart';

import '../model/videos_model.dart';
import '../../../core/utils/network_utils.dart';

class VideosRepo {
  static Future<VideosModel?> getVideos(
    context, {
    required int page,
    required int? userId,
  }) async {
    final util = NetworkUtil();
    var isSpecificUser = userId != null;

    var response = await util.post(
      'videos${isSpecificUser ? '/user' : ''}?page=$page',
      context: context,
      body: FormData.fromMap({
        if (isSpecificUser) 'user_id': userId,
      }),
    );
    if (response == null) {
      return null;
    }
    var model = VideosModel.fromJson(response.data);

    return model;
  }
}
