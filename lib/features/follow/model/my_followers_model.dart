// To parse this JSON data, do
//
//     final myFollowersModel = myFollowersModelFromJson(jsonString);

import 'dart:convert';

import 'package:creen/features/follow/model/user_following_model.dart';

MyFollowersModel myFollowersModelFromJson(String str) =>
    MyFollowersModel.fromJson(json.decode(str));

String myFollowersModelToJson(MyFollowersModel data) =>
    json.encode(data.toJson());

class MyFollowersModel {
  MyFollowersModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Followers>? data;

  factory MyFollowersModel.fromJson(Map<String, dynamic> json) =>
      MyFollowersModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Followers>.from(
                json["data"].map((x) => Followers.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Followers {
  Followers({
    this.id,
    this.userId,
    this.userFollowing,
    this.createdAt,
    this.updatedAt,
    this.userFollowers,
  });

  int? id;
  int? userId;
  int? userFollowing;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserFollowers? userFollowers;

  factory Followers.fromJson(Map<String, dynamic> json) => Followers(
        id: json["id"],
        userId: json["user_id"],
        userFollowing: json["user_following"],
        createdAt: DateTime.tryParse(json["created_at"] ?? ''),
        updatedAt: DateTime.tryParse(json["updated_at"] ?? ''),
        userFollowers: json["user_followers"] == null
            ? null
            : UserFollowers.fromJson(json["user_followers"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_following": userFollowing,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_followers": userFollowers?.toJson(),
      };
}
