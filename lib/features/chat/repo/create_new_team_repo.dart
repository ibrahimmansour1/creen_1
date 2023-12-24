import 'package:dio/dio.dart';

import '../../../core/utils/network_utils.dart';
import '../model/create_new_team_model.dart';

class CreateNewTeamRepo {
  static Future<CreateNewTeamModel?> createNewTeam({
    required Map<String, dynamic> body,
  }) async {
    final util = NetworkUtil();

    var response = await util.post(
      'chats/addTeam',
      body: FormData.fromMap(body),
    );

    if (response == null) {
      return null;
    }
    var model = CreateNewTeamModel.fromJson(response.data);

    return model;
  }
}
