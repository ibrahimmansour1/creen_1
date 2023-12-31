import 'dart:developer';

import 'package:dio/dio.dart';

import '../model/create_steps_model.dart';
import '../../../core/utils/network_utils.dart';

class CreateStepsRepo {
  static Future<CreateStepsModel?> createSteps({
    required Map<String, dynamic> body,
    required bool isEdit,
  }) async {
    final util = NetworkUtil();
    String url = 'steps/${!isEdit ? 'create' : 'update'}';
    log('$body $url', name: 'create_or_update_step');
    var response = await util.post(
      url,
      body: FormData.fromMap(body),
    );

    if (response == null) {
      return null;
    }

    var model = CreateStepsModel.fromJson(response.data);
    return model;
  }
}
