import '../models/countries_model.dart';

import '../../../core/utils/network_utils.dart';

class CountriesRepo {
  static Future<CountriesModel?> getCountries() async {
    final util = NetworkUtil();

    var response = await util.get('countries');

    if (response == null) {
      return null;
    }

    var model = CountriesModel.fromJson(response.data);
    return model;
  }
}
