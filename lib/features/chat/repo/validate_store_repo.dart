import '../../../core/utils/network_utils.dart';
import '../../Auth/model/delete_account_model.dart';

class ValidateStoriesRepo {
  static Future<DeleteAccountModel?> validateStories() async {
    final util = NetworkUtil();

    var response = await util.post(
      'stories/destroyall',
    );

    if (response == null) {
      return null;
    }
// print("response.data ${response.data}");
    var model = DeleteAccountModel.fromJson(response.data);
    // print("model ${model}");
    return model;
  }
}
