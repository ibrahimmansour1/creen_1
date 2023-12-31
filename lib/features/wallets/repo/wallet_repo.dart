import '../models/wallets_model.dart';
import '../../../core/utils/network_utils.dart';

class WalletRepo {
  static Future<WalletsModel?> getWallets({required int page}) async {
    final util = NetworkUtil();

    var response = await util.post('wallets?page=$page');

    if (response == null) {
      return null;
    }
    var model = WalletsModel.fromJson(response.data);

    return model;
  }
}
