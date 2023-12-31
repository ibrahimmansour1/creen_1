// To parse this JSON data, do
//
//     final addCommentToPostModel = addCommentToPostModelFromJson(jsonString);

import 'dart:convert';

AddCommentToPostModel addCommentToPostModelFromJson(String str) =>
    AddCommentToPostModel.fromJson(json.decode(str));

String addCommentToPostModelToJson(AddCommentToPostModel data) =>
    json.encode(data.toJson());

class AddCommentToPostModel {
  AddCommentToPostModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  CommentData? data;

  factory AddCommentToPostModel.fromJson(Map<String, dynamic> json) =>
      AddCommentToPostModel(
        status: json["status"],
        message: json["message"],
        data: CommentData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class CommentData {
  CommentData({
    this.id,
    this.comment,
    this.postId,
    this.userId,
    this.liveId,
    this.userName,
    this.logo,
    this.createdAt,
    this.updatedAt,
    this.timeAgo,
  });

  int? id;
  String? comment;
  int? postId;
  int? userId;
  dynamic liveId;
  dynamic userName;
  dynamic logo;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? timeAgo;

  factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
        id: json["id"],
        comment: json["comment"],
        postId: json["post_id"],
        userId: json["user_id"],
        liveId: json["live_id"],
        userName: json["user_name"],
        logo: json["logo"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        timeAgo: json["time_ago"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "post_id": postId,
        "user_id": userId,
        "live_id": liveId,
        "user_name": userName,
        "logo": logo,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "time_ago": timeAgo,
      };
}
