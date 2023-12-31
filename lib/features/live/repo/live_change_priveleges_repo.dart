import 'dart:developer';

import 'package:creen/core/utils/laravel_exception.dart';
import 'package:creen/core/utils/network_utils.dart';

class LiveChangePrivelegesRepo{
  static Future<void> changeLiveUserPrivilege({
    required int liveUserId,
    required String priveleges,
  }) async {
    final util = NetworkUtil();
    var url =
        'live/users/changeprevielages?priveleges=$priveleges&id=$liveUserId';

    log('url is $url');
    // log('data is $body');
    var response = await util.post(
      url,
      // body:FormData.fromMap(body),
    );


    if (response?.statusCode == 404 || (response?.statusCode ?? 0) >= 500) {
      throw LaravelException(
          'Something went wrong \nSTATUS_CODE: ${response?.statusCode}');
    }
if(response?.statusCode == 200){
  log('user privelege changed successfully');
}

/*    try {
      // var model = response.data;
      LiveUserJoinModel model = LiveUserJoinModel.fromJson(response.data);
      // log(' live model title ${model.data?[0].title}\tdescription ${model.data?[0].description}\tlive_id ${model.data?[0].live_id}\tcreator.name ${model.data?[0].creator.name}\t');
      return model;
    } catch (error) {
      throw LaravelException('Something went wrong \n ${error.toString()}');
    }*/
  }
}