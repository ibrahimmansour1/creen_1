// To parse this JSON data, do
//
//     final myFollowingModel = myFollowingModelFromJson(jsonString);

import 'dart:convert';

import 'package:creen/features/follow/model/user_following_model.dart';

MyFollowingModel myFollowingModelFromJson(String str) =>
    MyFollowingModel.fromJson(json.decode(str));

String myFollowingModelToJson(MyFollowingModel data) =>
    json.encode(data.toJson());

class MyFollowingModel {
  MyFollowingModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Following>? data;

  factory MyFollowingModel.fromJson(Map<String, dynamic> json) =>
      MyFollowingModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Following>.from(
                json["data"].map((x) => Following.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Following {
  Following({
    this.id,
    this.userId,
    this.userFollowing,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  UserFollowers? userFollowing;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Following.fromJson(Map<String, dynamic> json) => Following(
        id: json["id"],
        userId: json["user_id"],
        userFollowing: json["user_following"] == null
            ? null
            : UserFollowers.fromJson(json["user_following"]),
        createdAt: DateTime.tryParse(json["created_at"] ?? ''),
        updatedAt: DateTime.tryParse(json["updated_at"] ?? ''),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_following": userFollowing?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

// class UserFollowing {
//   UserFollowing({
//     this.id,
//     this.name,
//     this.mobile,
//     this.email,
//     this.profile,
//     this.cover,
//     this.address,
//     this.age,
//     this.about,
//     this.gender,
//     this.levelId,
//     this.countryId,
//     this.cityId,
//     this.language,
//     this.invitationBy,
//     this.month,
//     this.emailVerifiedAt,
//     this.numOfRating,
//     this.rateAvg,
//     this.isFollow,
//     this.fcmToken,
//     this.programCount,
//   });

//   int? id;
//   String? name;
//   String? mobile;
//   String? email;
//   String? profile;
//   String? cover;
//   dynamic address;
//   int? age;
//   String? about;
//   String? gender;
//   int? levelId;
//   int? countryId;
//   int? cityId;
//   String? language;
//   int? invitationBy;
//   dynamic month;
//   dynamic emailVerifiedAt;
//   int? numOfRating;
//   String? rateAvg;
//   bool? isFollow;
//   String? fcmToken;
//   int? programCount;

//   factory UserFollowing.fromJson(Map<String, dynamic> json) => UserFollowing(
//         id: json["id"],
//         name: json["name"],
//         mobile: json["mobile"],
//         email: json["email"],
//         profile: json["profile"],
//         cover: json["cover"],
//         address: json["address"],
//         age: json["age"],
//         about: json["about"],
//         gender: json["gender"],
//         levelId: json["level_id"],
//         countryId: json["country_id"],
//         cityId: json["city_id"],
//         language: json["language"],
//         invitationBy: json["invitation_by"],
//         month: json["month"],
//         emailVerifiedAt: json["email_verified_at"],
//         numOfRating: json["num_of_rating"],
//         rateAvg: json["rate_avg"],
//         isFollow: json["is_follow"],
//         fcmToken: json["fcm_token"],
//         programCount: json["program_count"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "mobile": mobile,
//         "email": email,
//         "profile": profile,
//         "cover": cover,
//         "address": address,
//         "age": age,
//         "about": about,
//         "gender": gender,
//         "level_id": levelId,
//         "country_id": countryId,
//         "city_id": cityId,
//         "language": language,
//         "invitation_by": invitationBy,
//         "month": month,
//         "email_verified_at": emailVerifiedAt,
//         "num_of_rating": numOfRating,
//         "rate_avg": rateAvg,
//         "is_follow": isFollow,
//         "fcm_token": fcmToken,
//         "program_count": programCount,
//       };
// }
