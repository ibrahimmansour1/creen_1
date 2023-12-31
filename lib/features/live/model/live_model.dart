import 'dart:convert';
import 'dart:developer';
// import 'dart:developer';

import 'package:creen/features/follow/model/user_following_model.dart';

LiveModel allProductsModelFromJson(String str) =>
    LiveModel.fromJson(json.decode(str));

class LiveModel {
  LiveModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<LiveDataModel>? data;

  factory LiveModel.fromJson(Map<String, dynamic> json) {
    // log('json["data"] ${json["data"]}');
    // log('json["data"].length ${'${json["data"].runtimeType}' == '_Map<String, dynamic>'}');
    return LiveModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : (List<LiveDataModel>.from(
            json["data"].runtimeType.toString() == '_Map<String, dynamic>'
            ? [json["data"]].map((x) => LiveDataModel.fromJson(x))
                : json["data"].map((x) => LiveDataModel.fromJson(x))))
    ,
    );
  }
}

class LiveDataModel {
  int? id;
  String title;
  String? description;
  String join_method;
  String attendance_view;
  String attendance_share;
  String link_share;
  String privelegeComments;
  String gifts;
  String type;
  int? user_id;
  String? image;
  String? filename;
  int? live_id;
  String? live_link;
  String? youtube_link;
  int likes;
  String updated_at;
  String time_ago;
  UserFollowers creator;
  List<dynamic>? raiseHand;


  LiveDataModel({
    required this.id,
    required this.title,
    required this.description,
    required this.join_method,
    required this.attendance_view,
    required this.attendance_share,
    required this.link_share,
    required this.privelegeComments,
    required this.gifts,
    required this.type,
    required this.user_id,
    required this.image,
    required this.filename,
    required this.live_id,
    required this.live_link,
    required this.youtube_link,
    required this.likes,
    required this.updated_at,
    required this.time_ago,
    required this.creator,
    required this.raiseHand,

  });

  factory LiveDataModel.fromJson(Map<String, dynamic> json) {
    log('maincomments runtimeType ${json['maincomments'].runtimeType}');
    log(
        "json['maincomments'] != null && json['maincomments'].isNotEmpty ${json['maincomments'] !=
            null && json['maincomments'].isNotEmpty}");
    log("json['maincomments'] ${json['maincomments']}");
    return LiveDataModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      join_method: json['join_method'],
      attendance_view: json['attendance_view'],
      attendance_share: json['attendance_share'],
      link_share: json['link_share'],
      privelegeComments: json['comments'],
      gifts: json['gifts'],
      type: json['type'],
      user_id: json['user_id'],
      image: json['image'],
      filename: json['filename'],
      live_id: json['live_id'],
      live_link: json['live_link'],
      youtube_link: json['youtube_link'],
      likes: json['likes'],
      updated_at: json['updated_at'],
      time_ago: json['time_ago'],
      raiseHand: json['raisehands'],
      creator: UserFollowers.fromJson(json['creator']),
      /*users: json['users'] != null && json['users'].isNotEmpty ?
      List<LiveUser>.generate(json['users'].length, (index) =>
          LiveUser.fromJson(json['users'][index])) : []
      ,
      comments: json['maincomments'] != null && json['maincomments'].isNotEmpty
          ?
      List<Comment>.generate(json['maincomments'].length, (index) =>
          Comment.fromJson(json['maincomments'][index]))
          : [],
    */);
  }
}

class Comment {
/*  {
  "id": 7,
  "user_id": 11720,
  "comment": "gghgh",
  "live_id": 139,
  "updated_at": "2023-11-27 23:56:12",
  "time_ago": "7 seconds ago"
  }*/

  int? id;
  int? userId;
  String comment;
  int? liveId;
  String updatedAt;
  String timeAgo;

  Comment({
    this.id,
    this.userId,
    required this.comment,
    this.liveId,
    required this.updatedAt,
    required this.timeAgo,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json['id'],
        userId: json['user_id'],
        comment: json['comment'],
        liveId: json['live_id'],
        updatedAt: json['updated_at'],
        timeAgo: json['time_ago']);
  }
}

class LiveUser {
  int? id;
  int? liveID;
  int? userId;
  String? guest;
  int mic;
  int camera;
  int sound;
  String userPrivelege;
  String updatedAt;
  int commentPrivelege;
  int giftPrivelege;
  int userPublic;
  int chat;
  String? remoteID;
  String timeAgo;
  UserFollowers? user;

  LiveUser({
    required this.id, required this.liveID, required this.userId, required this.guest, required this.mic, required this.camera,
    required this.sound, required this.userPrivelege, required this.updatedAt, required this.commentPrivelege,required this.giftPrivelege,
    required this.userPublic, required this.chat, required this.remoteID, required this.timeAgo, required this.user});

  factory LiveUser.fromJson(json)=>
      LiveUser(
        id: json['id'],
        liveID: json['live_id'],
        userId: json['user_id'],
        guest: json['name'],
        mic: json['mic'],
        camera: json['camera'],
        sound: json['sound'],
        userPrivelege: json['priveleges'],
        updatedAt: json['updated_at'],
        commentPrivelege: json['comment'],
        userPublic: json['userpublic'],
        chat: json['chat'],
        remoteID: json['remote_id'],
        timeAgo: json['time_ago'],
        user: json['user'] != null ?UserFollowers.fromJson(json['user']):null, giftPrivelege: json['gift'],);//json['user']
}

class Paging{
 int currentPage;
 dynamic data;
 String firstPageUrl;
 String lastPageUrl;
 int total;
 int from;
 int lastPage;
 int to;

 Paging({
    required this.currentPage,
    this.data,
    required this.firstPageUrl,
    required this.lastPageUrl,
    required this.total,
    required this.from,
    required this.lastPage,
    required this.to,
  });

 factory Paging.fromJson(json)=>
     Paging(currentPage: json['currentPage'], firstPageUrl: json['firstPageUrl'], lastPageUrl: json['lastPageUrl'], total: json['total'], from: json['from'], lastPage: json['lastPage'], to: json['to']);
}