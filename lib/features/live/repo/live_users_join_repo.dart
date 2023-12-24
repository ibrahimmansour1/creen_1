import 'dart:developer';

import 'package:creen/core/utils/laravel_exception.dart';
import 'package:creen/core/utils/network_utils.dart';
import 'package:creen/features/live/model/LiveUserJoinModel.dart';

class LiveUsersJoinRepo{
  static Future<LiveUserJoinModel?> joinLiveUser({
    required int liveId,
    required int? remoteId,
    required String priveleges,
  }) async {
    final util = NetworkUtil();
    var url =
        'live/users/join?priveleges=$priveleges&live_id=$liveId&remote_id=$remoteId';

    log('url is $url');
    // log('data is $body');
    var response = await util.post(
      url,
      // body:FormData.fromMap(body),
    );


    if (response == null) {
      return null;
    }
    if (response.statusCode == 404 ||response.statusCode == 429|| (response.statusCode ?? 0) >= 500) {
      log('${LaravelException(
          'Something went wrong \nSTATUS_CODE: ${response.statusCode}')}');
      throw('${response.statusCode}');
 /*     throw LaravelException(
          'Something went wrong \nSTATUS_CODE: ${response.statusCode}');*/
    }


    try {
      // var model = response.data;
      LiveUserJoinModel model = LiveUserJoinModel.fromJson(response.data);
      // log(' live model title ${model.data?[0].title}\tdescription ${model.data?[0].description}\tlive_id ${model.data?[0].live_id}\tcreator.name ${model.data?[0].creator.name}\t');
      return model;
    } catch (error) {
      throw LaravelException('Something went wrong \n ${error.toString()}');
    }
  }
}