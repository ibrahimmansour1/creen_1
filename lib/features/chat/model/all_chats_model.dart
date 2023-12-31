// To parse this JSON data, do
//
//     final allChatsModel = allChatsModelFromJson(jsonString);

import 'dart:convert';

import 'package:creen/features/Auth/model/login_model.dart';
import 'package:equatable/equatable.dart';

AllChatsModel allChatsModelFromJson(String str) =>
    AllChatsModel.fromJson(json.decode(str));

String allChatsModelToJson(AllChatsModel data) => json.encode(data.toJson());

class AllChatsModel {
  AllChatsModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  ChatData? data;

  factory AllChatsModel.fromJson(Map<String, dynamic> json) {

    return AllChatsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : ChatData.fromJson(json["data"]),
      );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class ChatData {
  ChatData({
    this.id,
    this.userId,
    this.teamCode,
    this.activate,
    this.reciever,
    this.name,
    this.logo,
    this.deletedAt,
    this.timeAgo,
    this.user,
    this.recieverm,
    this.messages,
  });

  int? id;
  int? userId;
  dynamic teamCode;
  int? activate;
  int? reciever;
  dynamic name;
  dynamic logo;
  dynamic deletedAt;
  String? timeAgo;
  Recieverm? user;
  Recieverm? recieverm;
  List<Message>? messages;

  factory ChatData.fromJson(Map<String, dynamic> json) {
    // print("json user  =====> ${json["user"]}");
    return ChatData(
        id: json["id"],
        userId: json["user_id"],
        teamCode: json["team_code"],
        activate: json["activate"],
        reciever: json["reciever"],
        name: json["name"],
        logo: json["logo"],
        deletedAt: json["deleted_at"],
        timeAgo: json["time_ago"],
        user: json["user"] == null ? null : Recieverm.fromJson(json["user"]),
        recieverm:
             Recieverm.fromJson(json["recieverm"]),

        messages: json["messages"] == null
            ? []
            : List<Message>.from(
                json["messages"]!.map((x) => Message.fromJson(x))),
      );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "team_code": teamCode,
        "activate": activate,
        "reciever": reciever,
        "name": name,
        "logo": logo,
        "deleted_at": deletedAt,
        "time_ago": timeAgo,
        "user": user?.toJson(),
        "recieverm": recieverm?.toJson(),
        "messages": messages == null
            ? []
            : List<dynamic>.from(messages!.map((x) => x.toJson())),
      };
}

class Message extends Equatable {
  Message({
    this.id,
    this.userId,
    this.userName,
    this.chatId,
    this.image,
    this.description,
    this.status,
    this.senderId,
    this.record,
    this.pdf,
    this.deletedAt,
    this.timeAgo,
    this.user,
  });

  int? id;
  int? userId;
  String? userName;
  int? chatId;
  dynamic image;
  String? description;
  String? status;
  int? senderId;
  dynamic record;
  dynamic pdf;
  dynamic deletedAt;
  String? timeAgo;
  UserData? user;
  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        userId: json["user_id"],
        userName: json["user_name"],
        chatId: json["chat_id"],
        image: json["image"],
        description: json["description"],
        status: json["status"],
        senderId: json["sender_id"],
        record: json["record"],
        pdf: json["pdf"],
        deletedAt: json["deleted_at"],
        timeAgo: json["time_ago"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_name": userName,
        "chat_id": chatId,
        "image": image,
        "description": description,
        "status": status,
        "sender_id": senderId,
        "record": record,
        "pdf": pdf,
        "deleted_at": deletedAt,
        "time_ago": timeAgo,
      };

  @override
  List<Object?> get props => [
        id,
        userId,
        userName,
        chatId,
        image,
        description,
        status,
        senderId,
        record,
        pdf,
        deletedAt,
        timeAgo,
      ];
}

class Recieverm {
  Recieverm({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.profile,
    this.cover,
    this.address,
    this.age,
    this.about,
    this.gender,
    this.levelId,
    this.countryId,
    this.cityId,
    this.language,
    this.invitationBy,
    this.month,
    this.emailVerifiedAt,
    this.numOfRating,
    this.rateAvg,
    this.isFollow,
    this.fcmToken,
    this.programCount,
  });

  int? id;
  String? name;
  String? mobile;
  String? email;
  String? profile;
  String? cover;
  dynamic address;
  int? age;
  String? about;
  String? gender;
  int? levelId;
  int? countryId;
  int? cityId;
  String? language;
  dynamic invitationBy;
  DateTime? month;
  dynamic emailVerifiedAt;
  int? numOfRating;
  String? rateAvg;
  bool? isFollow;
  String? fcmToken;
  int? programCount;

  factory Recieverm.fromJson(Map<String, dynamic> json) => Recieverm(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        profile: json["profile"],
        cover: json["cover"],
        address: json["address"],
        age: json["age"],
        about: json["about"],
        gender: json["gender"],
        levelId: json["level_id"],
        countryId: json["country_id"],
        cityId: json["city_id"],
        language: json["language"],
        invitationBy: json["invitation_by"],
        month: json["month"] == null ? null : DateTime.parse(json["month"]),
        emailVerifiedAt: json["email_verified_at"],
        numOfRating: json["num_of_rating"],
        rateAvg: json["rate_avg"],
        isFollow: json["is_follow"],
        fcmToken: json["fcm_token"],
        programCount: json["program_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "email": email,
        "profile": profile,
        "cover": cover,
        "address": address,
        "age": age,
        "about": about,
        "gender": gender,
        "level_id": levelId,
        "country_id": countryId,
        "city_id": cityId,
        "language": language,
        "invitation_by": invitationBy,
        "month": month?.toIso8601String(),
        "email_verified_at": emailVerifiedAt,
        "num_of_rating": numOfRating,
        "rate_avg": rateAvg,
        "is_follow": isFollow,
        "fcm_token": fcmToken,
        "program_count": programCount,
      };
}
