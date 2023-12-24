import '../../../core/utils/network_utils.dart';
import '../model/delete_account_model.dart';

class DeleteAccountRepo {
  static Future<DeleteAccountModel?> deleteAccount() async {
    final util = NetworkUtil();

    var response = await util.post(
      'profile/delete',
    );
    if (response == null) {
      return null;
    }
    var model = DeleteAccountModel.fromJson(response.data);

    return model;
  }
}
