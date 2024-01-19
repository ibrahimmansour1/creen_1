import 'package:dio/dio.dart';

import '../models/send_points_model.dart';
import '../../../core/utils/network_utils.dart';

class TransferPointsToUserRepo {
  static Future<TransferPointsModel?> transfer({
    required Map<String, dynamic> body,
  }) async {
    final util = NetworkUtil();

    var response = await util.post(
      'points/sendToUser',
      body: FormData.fromMap(
        body,
      ),
    );
    if (response == null) {
      return null;
    }
    var model = TransferPointsModel.fromJson(response.data);

    return model;
  }
}
