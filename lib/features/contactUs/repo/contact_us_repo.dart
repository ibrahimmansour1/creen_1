import 'package:dio/dio.dart';

import '../model/contact_us_model.dart';
import '../../../core/utils/network_utils.dart';

class ContactUsRepo {
  static Future<ContactUsModel?> submitMessage({
    required Map<String, dynamic> body,
  }) async {
    final util = NetworkUtil();

    var response = await util.post(
      'contactus',
      body: FormData.fromMap(body),
    );
    if (response == null) {
      return null;
    }
    var model = ContactUsModel.fromJson(response.data);
    return model;
  }
}
