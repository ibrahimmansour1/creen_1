import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../core/utils/network_utils.dart';

class UpdateStorySeenRepo {
  static Future</*DeleteBlogModel?*/void> updateSeen({
    required int storyId,
  }) async {
    final util = NetworkUtil();
    var map = {
      'story_id': storyId,
    };
    log('$map', name: 'stories/show');
    var response = await util.post(
      'stories/show',
      body: FormData.fromMap(map),
    );
    /*if (response == null) {
      return null;
    }
    var model = DeleteBlogModel.fromJson(response.data);

    return model;*/

  }
}
