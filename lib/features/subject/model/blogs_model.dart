// To parse this JSON data, do
//
//     final blogsModel = blogsModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../Auth/model/login_model.dart';

BlogsModel blogsModelFromJson(String str) =>
    BlogsModel.fromJson(json.decode(str));

String blogsModelToJson(BlogsModel data) => json.encode(data.toJson());

class BlogsModel {
  BlogsModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory BlogsModel.fromJson(Map<String, dynamic> json) => BlogsModel(
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
  List<Blogs>? data;
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Blogs>.from(json["data"].map((x) => Blogs.fromJson(x))),
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

class Blogs extends Equatable {
  Blogs({
    this.id,
    this.title,
    this.content,
    this.youtube,
    this.image,
    this.categoryId,
    this.userId,
    this.keywords,
    this.description,
    this.special,
    this.status,
    this.seen,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.commentsCount,
    this.likesCount,
    this.imagesCount,
    this.isLike,
    this.isLikeWeb,
    this.user,
    this.category,
    this.comments,
    this.images,
    this.retweets,
    this.retweetsCount,
  });

  int? id;
  String? title;
  String? content;
  String? youtube;
  String? image;
  int? categoryId;
  int? userId;
  String? keywords;
  dynamic description;
  int? special;
  int? status;
  int? seen;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? commentsCount;
  int? likesCount;
  int? imagesCount;
  bool? isLike;
  bool? isLikeWeb;
  UserData? user;
  Category? category;
  int? retweetsCount;
  List<Retweet>? retweets;
  List<Comment>? comments;
  List<Images>? images;
  factory Blogs.fromJson(Map<String, dynamic> json) => Blogs(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        youtube: json["youtube"],
        image: json["image"],
        categoryId: json["category_id"],
        userId: json["user_id"],
        keywords: json["keywords"],
        description: json["description"],
        special: json["special"],
        status: json["status"],
        seen: json["seen"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        commentsCount: json["comments_count"],
        likesCount: json["likes_count"],
        imagesCount: json["images_count"],
        isLike: json["is_like"],
        isLikeWeb: json["is_like_web"],
        retweetsCount: json["retweets_count"],
        retweets: json["retweets"] == null
            ? []
            : List<Retweet>.from(
                json["retweets"]!.map(
                  (x) => Retweet.fromJson(x),
                ),
              ),
        user: json["user"] == null ? null : UserData.fromJson(json["user"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        comments: json["comments"] == null
            ? []
            : List<Comment>.from(
                json["comments"].map(
                  (x) => Comment.fromJson(x),
                ),
              ),
        images: json["images"] == null
            ? []
            : List<Images>.from(json["images"]!.map((x) => Images.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "youtube": youtube,
        "image": image,
        "category_id": categoryId,
        "user_id": userId,
        "keywords": keywords,
        "retweets_count": retweetsCount,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "retweets": retweets == null
            ? []
            : List<dynamic>.from(retweets!.map((x) => x.toJson())),
        "description": description,
        "special": special,
        "status": status,
        "seen": seen,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "comments_count": commentsCount,
        "likes_count": likesCount,
        "images_count": imagesCount,
        "is_like": isLike,
        "is_like_web": isLikeWeb,
        "user": user?.toJson(),
        "category": category?.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        youtube,
        image,
        categoryId,
        userId,
        keywords,
        description,
        special,
        status,
        seen,
        deletedAt,
        createdAt,
        updatedAt,
        commentsCount,
        likesCount,
        imagesCount,
        isLike,
        isLikeWeb,
        user,
        category,
        images,
      ];
}

class Category {
  Category({
    this.id,
    this.sort,
    this.slug,
    this.icon,
    this.image,
    this.color,
    this.keywords,
    this.description,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.images,
  });

  int? id;
  int? sort;
  String? slug;
  String? icon;
  String? image;
  dynamic color;
  String? keywords;
  String? description;
  dynamic parentId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  List<Images>? images;
  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        sort: json["sort"],
        slug: json["slug"],
        icon: json["icon"],
        image: json["image"],
        color: json["color"],
        keywords: json["keywords"],
        description: json["description"],
        parentId: json["parent_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"],
        images: json["images"] == null
            ? []
            : List<Images>.from(json["images"]!.map((x) => Images.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sort": sort,
        "slug": slug,
        "icon": icon,
        "image": image,
        "color": color,
        "keywords": keywords,
        "description": description,
        "parent_id": parentId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
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
//   dynamic levelId;
//   int? countryId;
//   int? cityId;
//   String? language;
//   dynamic invitationBy;
//   String? month;
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
//         levelId: json["level_id"],
//         countryId: json["country_id"],
//         cityId: json["city_id"],
//         language: json["language"],
//         invitationBy: json["invitation_by"],
//         month: json["month"],
//         emailVerifiedAt: json["email_verified_at"],
//         numOfRating: json["num_of_rating"],
//         rateAvg: json["rate_avg"] == null ? null : json["rate_avg"],
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
//         "rate_avg": rateAvg == null ? null : rateAvg,
//         "is_follow": isFollow,
//         "fcm_token": fcmToken,
//         "program_count": programCount,
//       };
// }

class Comment  {
  Comment({
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
    this.user,
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
  UserData? user;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
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
      user: json["user"] == null ? null : UserData.fromJson(json["user"]));

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
        "user": user?.toJson(),
      };
}

class Images {
  Images({
    this.id,
    this.filename,
    this.originalFilename,
    this.url,
    this.postId,
    this.programBlogsId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? filename;
  String? originalFilename;
  String? url;
  int? postId;
  dynamic programBlogsId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        id: json["id"],
        filename: json["filename"],
        originalFilename: json["original_filename"],
        url: json["url"],
        postId: json["post_id"],
        programBlogsId: json["program_blogs_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "filename": filename,
        "original_filename": originalFilename,
        "url": url,
        "post_id": postId,
        "program_blogs_id": programBlogsId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Retweet extends Equatable {
  Retweet({
    this.id,
    this.postId,
    this.userId,
    this.userName,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.user,
  });

  int? id;
  int? postId;
  int? userId;
  String? userName;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  UserData? user;

  factory Retweet.fromJson(Map<String, dynamic> json) => Retweet(
        id: json["id"],
        postId: json["post_id"],
        userId: json["user_id"],
        userName: json["user_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        user: json["user"] == null ? null : UserData.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "post_id": postId,
        "user_id": userId,
        "user_name": userName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "user": user?.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        postId,
        userId,
        userName,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}
