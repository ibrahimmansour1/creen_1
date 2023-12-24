// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.status,
    this.message,
    this.data,
    this.errorMessages,
  });

  bool? status;
  String? message;
  UserData? data;
  Map<String, List<String>>? errorMessages;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        errorMessages:
            json["message"].runtimeType != String && json["message"] != null
                ? Map.from(json["message"]).map((k, v) =>
                    MapEntry<String, List<String>>(
                        k, List<String>.from(v.map((x) => x))))
                : null,
        message: json["message"].runtimeType == String ? json["message"] : null,
        data: json["data"] == null ? null : UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class UserData {
  UserData({
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
    this.apiToken,
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
  dynamic profile;
  dynamic cover;
  dynamic address;
  int? age;
  dynamic about;
  String? gender;
  dynamic levelId;
  int? countryId;
  int? cityId;
  String? language;
  String? apiToken;
  dynamic invitationBy;
  String? month;
  dynamic emailVerifiedAt;
  int? numOfRating;
  dynamic rateAvg;
  bool? isFollow;
  String? fcmToken;
  int? programCount;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
        apiToken: json["api_token"],
        invitationBy: json["invitation_by"],
        month: json["month"],
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
        "api_token": apiToken,
        "invitation_by": invitationBy,
        "month": month,
        "email_verified_at": emailVerifiedAt,
        "num_of_rating": numOfRating,
        "rate_avg": rateAvg,
        "is_follow": isFollow,
        "fcm_token": fcmToken,
        "program_count": programCount,
      };
}
