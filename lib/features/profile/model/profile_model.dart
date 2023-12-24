// To parse this JSON data, do
//
//     final myFollowersModel = myFollowersModelFromJson(jsonString);

import 'dart:convert';

ProfileModel myFollowersModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String myFollowersModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  ProfileData? data;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class ProfileData {
  ProfileData({
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
    this.blogsCount,
    this.followingCount,
    this.followersCount,
    this.numOfRating,
    this.rateAvg,
    this.isFollow,
    this.fcmToken,
    this.programCount,
    this.level,
  });

  int? id;
  String? name;
  String? mobile;
  String? email;
  dynamic profile;
  dynamic cover;
  dynamic address;
  dynamic age;
  dynamic about;
  String? gender;
  dynamic levelId;
  int? countryId;
  int? cityId;
  String? language;
  dynamic invitationBy;
  String? month;
  dynamic emailVerifiedAt;
  int? blogsCount;
  int? followingCount;
  int? followersCount;
  int? numOfRating;
  dynamic rateAvg;
  bool? isFollow;
  String? fcmToken;
  int? programCount;
  dynamic level;

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
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
        month: json["month"],
        emailVerifiedAt: json["email_verified_at"],
        blogsCount: json["blogs_count"],
        followingCount: json["following_count"],
        followersCount: json["followers_count"],
        numOfRating: json["num_of_rating"],
        rateAvg: json["rate_avg"],
        isFollow: json["is_follow"],
        fcmToken: json["fcm_token"],
        programCount: json["program_count"],
        level: json["level"],
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
        "month": month,
        "email_verified_at": emailVerifiedAt,
        "blogs_count": blogsCount,
        "following_count": followingCount,
        "followers_count": followersCount,
        "num_of_rating": numOfRating,
        "rate_avg": rateAvg,
        "is_follow": isFollow,
        "fcm_token": fcmToken,
        "program_count": programCount,
        "level": level,
      };
}
