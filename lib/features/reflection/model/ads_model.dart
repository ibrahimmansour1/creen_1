// To parse this JSON data, do
//
//     final adsModel = adsModelFromJson(jsonString);

import 'dart:convert';

AdsModel adsModelFromJson(String str) => AdsModel.fromJson(json.decode(str));

String adsModelToJson(AdsModel data) => json.encode(data.toJson());

class AdsModel {
  AdsModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Ads>? data;

  factory AdsModel.fromJson(Map<String, dynamic> json) => AdsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Ads>.from(json["data"].map((x) => Ads.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Ads {
  Ads({
    this.id,
    this.userId,
    this.productId,
    this.title,
    this.image,
    this.video,
    this.duration,
    this.url,
    this.link,
    this.whatsapp,
    this.status,
    this.views,
    this.clicks,
    this.endAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  dynamic productId;
  String? title;
  String? image;
  dynamic video;
  int? duration;
  String? url;
  String? link;
  String? whatsapp;
  String? status;
  int? views;
  int? clicks;
  DateTime? endAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Ads.fromJson(Map<String, dynamic> json) => Ads(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        title: json["title"],
        image: json["image"],
        video: json["video"],
        duration: json["duration"],
        url: json["url"],
        link: json["link"],
        whatsapp: json["whatsapp"],
        status: json["status"],
        views: json["views"],
        clicks: json["clicks"],
        endAt: DateTime.tryParse(json["end_at"] ?? ''),
        createdAt: DateTime.tryParse(json["created_at"] ?? ''),
        updatedAt: DateTime.tryParse(json["updated_at"] ?? ''),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "title": title,
        "image": image,
        "video": video,
        "duration": duration,
        "url": url,
        "link": link,
        "whatsapp": whatsapp,
        "status": status,
        "views": views,
        "clicks": clicks,
        "end_at": endAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
