import 'dart:developer';

import 'package:creen/features/subject/model/delete_blogs_model.dart';
import 'package:dio/dio.dart';

import '../../../core/utils/network_utils.dart';

class DeleteStoryRepo {
  static Future<DeleteBlogModel?> deleteStory({
    required int storyId,
  }) async {
    final util = NetworkUtil();
    var map = {
      'story_id': storyId,
    };
    log('$map', name: 'deleteStory');
    var response = await util.post(
      'stories/destroy',
      body: FormData.fromMap(map),
    );
    if (response == null) {
      return null;
    }
    var model = DeleteBlogModel.fromJson(response.data);

    return model;
  }
}
