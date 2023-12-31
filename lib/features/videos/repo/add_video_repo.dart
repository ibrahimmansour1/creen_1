import 'dart:developer';

import 'package:dio/dio.dart';

import '../model/add_video_model.dart';
import '../../../core/utils/network_utils.dart';

class NewVideoRepo {
  static Future<AddVideoModel?> addNewVideo({
    required Map<String, dynamic> body,
  }) async {
    final util = NetworkUtil();
    log('create $body');
    var response = await util.post(
      'videos/create',
      body: FormData.fromMap(body),
    );
    if (response == null) {
      return null;
    }

    var model = AddVideoModel.fromJson(response.data);
    return model;
  }
}
