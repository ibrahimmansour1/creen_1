import 'dart:developer';

import 'package:creen/core/utils/laravel_exception.dart';
import 'package:creen/core/utils/network_utils.dart';

class FollowersRepo{
  static Future<List<Follower>?> getFollowers({
    required int userId,

  }) async {
    final util = NetworkUtil();
    var url =
        'followers/followers?user_id=$userId';

    log('url is $url');
    // log('data is $body');
    var response = await util.post(
      url,
      // body:FormData.fromMap(body),
    );

    if (response == null) {
      return null;
    }
    if (response.statusCode == 404 || (response.statusCode ?? 0) >= 500) {
      throw LaravelException(
          'Something went wrong \nSTATUS_CODE: ${response.statusCode}');
    }
    List<Follower> followers = [];
if(response.statusCode == 200) {
  for(Map<String,dynamic> data in response.data["data"])
    {
      var element = data["user_followers"];
      followers.add(Follower(id: element["id"], name: element["name"],
          profile: element["profile"]
      ));
    }
}
      return followers;

    /* try {
      var model = LiveModel.fromJson(response.data);
      // log(' live model ${model.data?[0].title}');
      return model;
    } catch (error) {
      throw LaravelException('Something went wrong \n ${error.toString()}');
    }*/
  }
}

class Follower{
  int? id;
  String name;
  String? profile;

  Follower({
    required this.id,
    required this.name,
    required this.profile,
  });
}