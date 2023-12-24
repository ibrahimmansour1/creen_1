// To parse this JSON data, do
//
//     final retweetModel = retweetModelFromJson(jsonString);

import 'dart:convert';

RetweetModel retweetModelFromJson(String str) => RetweetModel.fromJson(json.decode(str));

String retweetModelToJson(RetweetModel data) => json.encode(data.toJson());

class RetweetModel {
    RetweetModel({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    Data? data;

    factory RetweetModel.fromJson(Map<String, dynamic> json) => RetweetModel(
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
        this.isLike,
        this.isLikeWeb,
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
    bool? isLike;
    bool? isLikeWeb;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        isLike: json["is_like"],
        isLikeWeb: json["is_like_web"],
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
        "description": description,
        "special": special,
        "status": status,
        "seen": seen,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_like": isLike,
        "is_like_web": isLikeWeb,
    };
}
