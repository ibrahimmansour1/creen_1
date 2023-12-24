import 'package:dio/dio.dart';

import '../model/create_new_story_model.dart';
import '../../../core/utils/network_utils.dart';

class CreateNewStoryRepo {
  static Future<CreateNewStoryModel?> createNewStory({
    required Map<String, dynamic> body,
  }) async {
    final util = NetworkUtil();
    // print("storiesData ${6666666}");

    var response = await util.post(
      'stories/store',
      body: FormData.fromMap(
        body,
      ),
    );

    if (response == null) {
      return null;
    }
    // print("storiesData ${response.data}");

    var model = CreateNewStoryModel.fromJson(response.data);
    return model;
  }
}
