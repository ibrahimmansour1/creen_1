import 'package:creen/core/utils/functions/helper_functions.dart';

import '../model/login_model.dart';
import '../../../core/utils/network_utils.dart';

class LogoutRepo {
  static Future<LoginModel?> logout() async {
    final util = NetworkUtil();

    var response = await util.post(
      'logout?api_token=${HelperFunctions.currentUser?.apiToken}',
      withHeader: false,
    );
    if(response==null){
      return null;

    }
    var model = LoginModel.fromJson(response.data);

    return model;
  }
}
