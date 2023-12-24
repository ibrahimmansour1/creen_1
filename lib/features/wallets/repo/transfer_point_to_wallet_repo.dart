import 'package:dio/dio.dart';

import '../models/send_point_to_wallet_model.dart';
import '../../../core/utils/network_utils.dart';

class TransferPointsToWalletRepo {
  static Future<TransferPointsToWalletModel?> transfer({
    required Map<String, dynamic> body,
  }) async {
    final util = NetworkUtil();

    var response = await util.post(
      'points/sendTowallet',
      body: FormData.fromMap(
        body,
      ),
    );
    if (response == null) {
      return null;
    }
    var model = TransferPointsToWalletModel.fromJson(response.data);

    return model;
  }
}
