import '../models/points_model.dart';
import '../../../core/utils/network_utils.dart';

class PointsRepo {
  static Future<PointsModel?> getPointss({required int page}) async {
    final util = NetworkUtil();

    var response = await util.post('points?page=$page');

    if (response == null) {
      return null;
    }
    var model = PointsModel.fromJson(response.data);

    return model;
  }
}
