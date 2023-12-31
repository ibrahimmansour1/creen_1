import 'package:dio/dio.dart';

import '../model/create_report_model.dart';
import '../../../core/utils/network_utils.dart';

class CreateReportRepo {
  static Future<CreateReportModel?> createReport({
    required Map<String, dynamic> body,
  }) async {
    final util = NetworkUtil();
    var response = await util.post(
      'reports/create',
      body: FormData.fromMap(body),
    );
    if (response == null) {
      return null;
    }

    var model = CreateReportModel.fromJson(response.data);
    return model;
  }
}
