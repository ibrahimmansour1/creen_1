import 'dart:developer';

import 'package:creen/core/utils/laravel_exception.dart';
import 'package:creen/core/utils/network_utils.dart';
import 'package:creen/features/live/model/LiveShowModel.dart';
import 'package:creen/features/live/model/live_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LiveDetailsShowRepo{
  static Future<LiveShowModel?> showLiveDetails({
    required int liveId,

  }) async {
    final util = NetworkUtil();
    var url =
        'live/show?id=$liveId';

    log('url is $url');
    // log('data is $body');
    var response = await util.post(
      url,
      // body:FormData.fromMap(body),
    );


    if (response == null) {
      return null;
    }
    // log('status ==> ${response.statusCode}');
    if(response.statusCode == 429){
      log('Too Too many Requests');
      Fluttertoast.showToast(msg: 'Too Many Requests');
    }
    else if (response.statusCode == 404 || (response.statusCode ?? 0) >= 500) {
      throw LaravelException(
          'Something went wrong \nSTATUS_CODE: ${response.statusCode}');
    }


    try {
      // var model = response.data;
      // log('live details show ${response.data}');
      LiveShowModel model = LiveShowModel.fromJson(response.data);
      // log('live users details show ${model.data?[0].type}');
      // log(' live model title ${model.data?[0].title}\tdescription ${model.data?[0].description}\tlive_id ${model.data?[0].live_id}\tcreator.name ${model.data?[0].creator.name}\t');
      return model;
    } catch (error) {
      throw LaravelException('Something went wrong \n ${error.toString()}');
    }
  }
}