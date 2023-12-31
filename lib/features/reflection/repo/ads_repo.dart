import '../model/ads_model.dart';
import '../../../core/utils/laravel_exception.dart';
import '../../../core/utils/network_utils.dart';

class AdsRepo {
  static Future<AdsModel?> getAds() async {
    final util = NetworkUtil();

    var response = await util.post(
      'promotions',
    );
    if (response == null) {
      return null;
    }

    if (response.statusCode == 404 || (response.statusCode ?? 0) >= 500) {
      throw LaravelException(
          'Something went wrong \nSTATUS_CODE: ${response.statusCode}');
    }
    try {
      var model = AdsModel.fromJson(response.data);
      return model;
    } catch (error) {
      throw LaravelException('Something went wrong \n${error.toString()}');
    }
  }
}
