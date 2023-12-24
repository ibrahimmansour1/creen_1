
import '../model/all_conversations_model.dart';
import '../../../core/utils/network_utils.dart';

class AllConversationsRepo {
  static Future<AllConversationsModel?> getAllConversations({
    required int page,
  }) async {
    final util = NetworkUtil();

    var response = await util.get(
      'chats?page=$page',
    );
    if (response == null) {
      return null;
    }
    // print('response data ===> ${response.data['data']['chats']['data'][0]/*["sender"]['id']*/}\n\n\n\n');
    // log("model1 ====> ${response.data["data"]["chats"]["data"][0]}");

    var model = AllConversationsModel.fromJson(response.data);
    // print("model ====> ${}");
    // log("model2 ====> ${response.data["data"]["chats"]["data"][0]}");
    // print("model ====> ${model.data?.chats?.data?[1].recieverm?.id}");
    // print("model ====> ${model.data?.chats?.data?[1].recieverm?.id}");
    // print("model ====> ${model.data?.chats?.data?[1].sender?.id}\n\n\n\n\n\n");
    // print("model ====> ${model.data?.chats?.data?[1].recieverm?.id}\n\n\n\n\n");

    return model;
  }
}
