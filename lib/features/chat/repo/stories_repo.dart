import '../model/stories_model.dart';
import '../../../core/utils/network_utils.dart';

class StoriesRepo {
  static Future<StoriesModel?> getStories({
    required int page,
  }) async {
    final util = NetworkUtil();

    var response = await util.post('stories?page=$page');

    if (response == null) {
      return null;
    }

    var model = StoriesModel.fromJson(response.data);
    return model;
  }
}
