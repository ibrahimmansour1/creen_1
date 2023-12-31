import 'dart:developer';

import 'package:dio/dio.dart';

import '../model/all_chats_model.dart';
import '../../../core/utils/network_utils.dart';

class SendMessageRepo {
  static Future<AllChatsModel?> sendMessage({
    required Map<String, dynamic> body,
    required bool isGroup,
     bool edtied = false,
  }) async {
    log('bod is $body');
    final util = NetworkUtil();
    var response;
if(edtied){
  response = await util.post(
    'chats/edit',
    body: FormData.fromMap(body),
  );
} else{
     response = await util.post(
      'chats/store${isGroup ? 't' : ''}',
      body: FormData.fromMap(body),
    );}
    if (response == null) {
      return null;
    }
    var model = AllChatsModel.fromJson(response.data);

    return model;
  }
}
