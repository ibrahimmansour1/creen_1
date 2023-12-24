// To parse this JSON data, do
//
//     final videosModel = videosModelFromJson(jsonString);

import 'dart:convert';

import 'package:creen/features/Auth/model/login_model.dart';

import '../../subject/model/blogs_model.dart';

VideosModel videosModelFromJson(String str) =>
    VideosModel.fromJson(json.decode(str));

String videosModelToJson(VideosModel data) => json.encode(data.toJson());

class VideosModel {
  VideosModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory VideosModel.fromJson(Map<String, dynamic> json) => VideosModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.videos,
  });

  Videos? videos;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        videos: json["videos"] == null ? null : Videos.fromJson(json["videos"]),
      );

  Map<String, dynamic> toJson() => {
        "videos": videos?.toJson(),
      };
}

class Videos {
  Videos({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<VideoData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? null
            : List<VideoData>.from(
                json["data"].map((x) => VideoData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class VideoData {
  VideoData({
    this.id,
    this.userId,
    this.filename,
    this.originalFilename,
    this.url,
    this.type,
    this.share,
    this.updatedAt,
    this.likesCount,
    this.timeAgo,
    this.user,
    this.comments,
    this.likes,
    this.description,
  });

  int? id;
  int? userId;
  String? filename;
  String? originalFilename;
  String? url;
  String? type;
  int? share;
  DateTime? updatedAt;
  int? likesCount;
  String? timeAgo;
  UserData? user;
  List<Comment>? comments;
  List<Like>? likes;
  String? description;

  factory VideoData.fromJson(Map<String, dynamic> json) => VideoData(
        id: json["id"],
        userId: json["user_id"],
        filename: json["filename"],
        originalFilename: json["original_filename"],
        url: json["url"],
        type: json["type"],
        share: json["share"],
        updatedAt: DateTime.tryParse(json["updated_at"] ?? ''),
        likesCount: json["likes_count"],
        timeAgo: json["time_ago"],
        user: json["user"] == null ? null : UserData.fromJson(json["user"]),
        comments: json["comments"] == null
            ? []
            : List<Comment>.from(
                json["comments"]!.map((x) => Comment.fromJson(x))),
        likes: json["likes"] == null
            ? []
            : List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "filename": filename,
        "original_filename": originalFilename,
        "url": url,
        "type": type,
        "share": share,
        "updated_at": updatedAt?.toIso8601String(),
        "likes_count": likesCount,
        "time_ago": timeAgo,
        "user": user?.toJson(),
        "comments": comments == null
            ? []
            : List<dynamic>.from(comments!.map((x) => x.toJson())),
        "likes": List<dynamic>.from(likes!.map((e) => e.toJson())),
        "description": description,
      };
}

// class User {
//   User({
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
//   dynamic age;
//   String? about;
//   String? gender;
//   int? levelId;
//   int? countryId;
//   int? cityId;
//   String? language;
//   dynamic invitationBy;
//   DateTime? month;
//   dynamic emailVerifiedAt;
//   int? numOfRating;
//   String? rateAvg;
//   bool? isFollow;
//   String? fcmToken;
//   int? programCount;

//   factory User.fromJson(Map<String, dynamic> json) => User(
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
//         levelId: json["level_id"] == null ? null : json["level_id"],
//         countryId: json["country_id"],
//         cityId: json["city_id"],
//         language: json["language"],
//         invitationBy: json["invitation_by"],
//         month: DateTime.tryParse(json["month"] ?? ''),
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
//         "month": month?.toIso8601String(),
//         "email_verified_at": emailVerifiedAt,
//         "num_of_rating": numOfRating,
//         "rate_avg": rateAvg,
//         "is_follow": isFollow,
//         "fcm_token": fcmToken,
//         "program_count": programCount,
//       };
// }

class Like {
  Like({
    this.id,
    this.userId,
    this.liveId,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  int? userId;
  int? liveId;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserData? user;

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        id: json["id"],
        userId: json["user_id"],
        liveId: json["live_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : UserData.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "live_id": liveId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
      };
}
