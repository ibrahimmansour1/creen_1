import 'package:creen/core/utils/network_utils.dart';
import 'package:creen/features/live/model/follow_status_model.dart';
import 'package:dio/dio.dart';

class FollowersStatus{
  static Future<FollowStatusModel?> followStatus(
      {
required int? userId,
      }) async {
    final util = NetworkUtil();

    var response = await util.post(
      'followers/isfollow',
      body: FormData.fromMap({
        'user_id':userId
      })
    );
    if (response == null) {
      return null;
    }

    var model = FollowStatusModel.fromJson(response.data);

    return model;
  }
}