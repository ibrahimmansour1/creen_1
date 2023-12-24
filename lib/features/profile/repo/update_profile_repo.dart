import 'package:dio/dio.dart';

import '../../../core/utils/laravel_exception.dart';
import '../model/profile_model.dart';
import '../../../core/utils/network_utils.dart';

class UpdateProfileRepo {
  static Future<ProfileModel?> updateProfileData(
    context, {
    required Map<String, dynamic> body,
  }) async {
    final util = NetworkUtil();
    var response = await util.post(
      'profile/update',
      body: FormData.fromMap(body),
    );
    if (response == null) {
      return null;
    }

    if (response.statusCode == 404 || (response.statusCode ?? 0) >= 500) {
      throw LaravelException(
        'Something went wrong \nSTATUS_CODE:${response.statusCode}',
      );
    }
    try {
      var model = ProfileModel.fromJson(response.data);
      return model;
    } catch (error) {
      throw LaravelException(
        'Something went wrong \n${error.toString()}',
      );
    }
  }
}
