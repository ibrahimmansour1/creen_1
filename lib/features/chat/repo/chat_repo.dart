import 'package:dio/dio.dart';

import '../../../core/utils/network_utils.dart';

class ChatRepo{
  static Future<void> deleteChatMessage({
    required int messageId,
    bool message = true

  }) async {
    final util = NetworkUtil();


    var map = {
if(message)
        'message_id': messageId
      else
        'chat_id':messageId

    };

    // log(map.toString(), name: 'AllChatsBody');
    var url;
    if(message) {
      url = 'chats/deletemessage';
    } else {
      url = 'chats/delete';
    }

    var response = await util.post(url, body: FormData.fromMap(map));
    if (response == null) {
      return null;
    }

    print("delete response   =====> ${response}");
    // print("conversation           ======>  ${response.data["data"]["chats"]}");

    // var model = AllChatsModel.fromJson(response.data);
    // print("model =====================> ${model}\n\n");
    // return model;



  }


  static Future<void> editChatMessage({
    required int receiverId,
    String? text,
    String? message_id,
    dynamic image,
    dynamic record,
    dynamic pdf,
    dynamic video,

  }) async {
    final util = NetworkUtil();


    var map = {

      'receiver_id': receiverId,
      'text': text,
      'image': image,
      'record': record,
      'pdf': pdf,
      'video': video,
      'message_id': message_id,

    };

    // log(map.toString(), name: 'AllChatsBody');
    var url = 'chats/editmessage';

    var response = await util.post(url, body: FormData.fromMap(map));
    if (response == null) {
      return null;
    }
    // print("conversation           ======>  ${response.data["data"]["chats"]}");

    // var model = AllChatsModel.fromJson(response.data);
    // print("model =====================> ${model}\n\n");
    // return model;



  }
}