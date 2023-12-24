import 'package:flutter/foundation.dart';

import '../model/steps_model.dart';
import '../../../core/utils/network_utils.dart';

class StepsRepo {
  static Future<StepsModel?> getSteps() async {
    final util = NetworkUtil();

    var response = await util.post('steps');

    if (response == null) {
      return null;
    }
if (kDebugMode) {
  print("getsteps ${response.data}");
}
    var model = StepsModel.fromJson(response.data);
    return model;
  }
}
