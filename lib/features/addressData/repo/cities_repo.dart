import 'package:dio/dio.dart';

import '../models/cities_model.dart';
import '../../../core/utils/network_utils.dart';

class CitiesRepo {
  static Future<CitiesModel?> getCitiesByCountryId(
      {required int? countryId}) async {
    final util = NetworkUtil();

    var response = await util.post('countries/cities',
        body: FormData.fromMap({
          'country_id': countryId,
        }));

    if (response == null) {
      return null;
    }

    var model = CitiesModel.fromJson(response.data);

    return model;
  }
}
