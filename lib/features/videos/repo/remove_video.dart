import 'package:creen/features/videos/model/remove_video_model.dart';
import 'package:dio/dio.dart';
import '../../../core/utils/network_utils.dart';

class RemoveVideoRepo {
  static Future<removeVideoModel?> removeVideo(
      context, {
        required Map<String, dynamic> body,
      }) async {
    final util = NetworkUtil();

    var response = await util.post(
      'videos/delete',
      body: FormData.fromMap(
        body,
      ),
    );
    if (response == null) {
      return null;
    }

    var model = removeVideoModel.fromJson(response.data);

    return model;
  }
}