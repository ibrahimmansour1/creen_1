import 'dart:developer';

import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:dio/dio.dart';

import '../model/all_chats_model.dart';
import '../../../core/utils/network_utils.dart';

class AllChatsRepo {
  static Future<AllChatsModel?> getAllChats({
    required int? recieverId,
    required int? conversationId,
  }) async {
    final util = NetworkUtil();
    var isshowChat2 = conversationId == null;

    var map = {
      if (recieverId != null) ...{
        'reciever_id': recieverId,
      },
      if (conversationId != null) ...{
        'chat_id': conversationId,
      },
    };

    // log(map.toString(), name: 'AllChatsBody');
    var url = 'chats/show${isshowChat2 ? '2' : ''}';
    log('$url $map myUserID ${HelperFunctions.currentUser?.id}',
        name: 'AllChatsBody');
    var response = await util.post(url, body: FormData.fromMap(map));
    if (response == null) {
      return null;
    }
    // print("conversation           ======>  ${response.data["data"]["chats"]}");

      var model = AllChatsModel.fromJson(response.data);
      // print("model =====================> ${model}\n\n");
      return model;



  }
}
