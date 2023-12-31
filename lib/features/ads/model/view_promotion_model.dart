// To parse this JSON data, do
//
//     final viewPromotionModel = viewPromotionModelFromJson(jsonString);

import 'dart:convert';

import 'package:creen/features/ads/model/ad_data.dart';

import '../../Auth/model/login_model.dart';

ViewPromotionModel viewPromotionModelFromJson(String str) =>
    ViewPromotionModel.fromJson(json.decode(str));

String viewPromotionModelToJson(ViewPromotionModel data) =>
    json.encode(data.toJson());

class ViewPromotionModel {
  bool? status;
  String? message;
  PromotionData? data;

  ViewPromotionModel({
    this.status,
    this.message,
    this.data,
  });

  factory ViewPromotionModel.fromJson(Map<String, dynamic> json) =>
      ViewPromotionModel(
        status: json["status"],
        message: json["message"],
        data:
            json["data"] == null ? null : PromotionData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class PromotionData {
  int? id;
  int? promotionCategoryId;
  int? userId;
  String? whatsapp;
  dynamic link;
  String? type;
  int? clicks;
  int? seen;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Images>? images;
  List<Images>? videos;
  dynamic product;
  Text? text;
  UserData? user;

  PromotionData({
    this.id,
    this.promotionCategoryId,
    this.userId,
    this.whatsapp,
    this.link,
    this.type,
    this.clicks,
    this.seen,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.videos,
    this.product,
    this.text,
    this.user,
  });

  factory PromotionData.fromJson(Map<String, dynamic> json) => PromotionData(
        id: json["id"],
        promotionCategoryId: json["promotion_category_id"],
        userId: json["user_id"],
        whatsapp: json["whatsapp"],
        link: json["link"],
        type: json["type"],
        clicks: json["clicks"],
        seen: json["seen"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        images: json["images"] == null
            ? []
            : List<Images>.from(json["images"]!.map((x) => Images.fromJson(x))),
        user: json["user"] == null ? null : UserData.fromJson(json["user"]),
        videos: json["videos"] == null
            ? []
            : List<Images>.from(json["videos"]!.map((x) => Images.fromJson(x))),
        product: json["product"],
        text: json["text"] == null ? null : Text.fromJson(json["text"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "promotion_category_id": promotionCategoryId,
        "user_id": userId,
        "whatsapp": whatsapp,
        "link": link,
        "type": type,
        "clicks": clicks,
        "seen": seen,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "videos":
            videos == null ? [] : List<dynamic>.from(videos!.map((x) => x)),
        "product": product,
        "text": text?.toJson(),
        "user": user?.toJson(),
      };
}

class Images {
  int? id;
  int? promotionId;
  String? filename;
  String? originalFilename;
  String? url;
  DateTime? createdAt;
  DateTime? updatedAt;

  Images({
    this.id,
    this.promotionId,
    this.filename,
    this.originalFilename,
    this.url,
    this.createdAt,
    this.updatedAt,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        id: json["id"],
        promotionId: json["promotion_id"],
        filename: json["filename"],
        originalFilename: json["original_filename"],
        url: json["url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "promotion_id": promotionId,
        "filename": filename,
        "original_filename": originalFilename,
        "url": url,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
