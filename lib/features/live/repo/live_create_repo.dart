

import 'dart:developer';

import 'package:creen/core/utils/laravel_exception.dart';
import 'package:creen/core/utils/network_utils.dart';
import 'package:creen/features/live/model/live_model.dart';
import 'package:dio/dio.dart';


class LiveCreateRepo {
  // LiveModel?
  static Future<LiveModel?> createLive({
    required String title,
    required String join_method,
    required String attendance_view,
    required String attendance_share,
    required String link_share,
    required String comments,
    required String gifts,
    required String type,
    required String? description,
    required dynamic image,
    required String? live_id,
    required String? live_link,
    required String? youtube_link,
}) async {
    final util = NetworkUtil();

    var url =
        'live/store';
    Map<String,dynamic> body = {
      'title':title,
      'join_method':join_method,
      'attendance_view':attendance_view,
      'attendance_share':attendance_share,
      'link_share':link_share,
      'comments':comments,
      'gifts':gifts,
      'type':type,
      if(description != null)
      'description':description,
      if(image != null)
        'image':image,
      if(live_id != null)
        'live_id':live_id,
      if(live_link != null)
        'live_link':live_link,
      if(youtube_link != null)
        'youtube_link':youtube_link,
    };

    log('url is $url');
    log('data is $body');
    var response = await util.post(
      url,
      body:FormData.fromMap(body),
    );

    if (response == null) {
      return null;
    }
    if (response.statusCode == 404 || (response.statusCode ?? 0) >= 500) {
      throw LaravelException(
          'Something went wrong \nSTATUS_CODE: ${response.statusCode}');
    }


    try {
      // var model = response.data;
      var model = LiveModel.fromJson(response.data);
      log(' live model title ${model.data?[0].title}\tdescription ${model.data?[0].description}\tlive_id ${model.data?[0].live_id}\tcreator.name ${model.data?[0].creator.name}\t');
      return model;
    } catch (error) {
      throw LaravelException('Something went wrong \n ${error.toString()}');
    }
  }
}
