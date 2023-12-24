import '../model/categories_model.dart';
import '../../../core/utils/network_utils.dart';

class CategoriesRepo {
  static Future<CategoriesModel?> getCategories(context) async {
    final util = NetworkUtil();

    var response = await util.get(
      'categories',
      context: context,
    );
    if (response == null) {
      return null;
    }

    var model = CategoriesModel.fromJson(response.data);

    return model;
  }
}
