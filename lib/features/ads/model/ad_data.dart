import 'package:equatable/equatable.dart';

class AdData extends Equatable {
  AdData({
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
    this.image,
    this.video,
    this.product,
    this.text,
  });

  int? id;
  int? promotionCategoryId;
  int? userId;
  String? whatsapp;
  String? link;
  String? type;
  int? clicks;
  int? seen;
  DateTime? createdAt;
  DateTime? updatedAt;
  Image? image;
  Image? video;
  dynamic product;
  Text? text;

  factory AdData.fromJson(Map<String, dynamic> json) => AdData(
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
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        video: json["video"] == null ? null : Image.fromJson(json["video"]),
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
        "image": image?.toJson(),
        "video": video?.toJson(),
        "product": product,
        "text": text?.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        promotionCategoryId,
        userId,
        whatsapp,
        link,
        type,
        clicks,
        seen,
        createdAt,
        updatedAt,
        image,
        video,
        product,
        text,
      ];
}

class Image {
  Image({
    this.id,
    this.promotionId,
    this.filename,
    this.originalFilename,
    this.url,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? promotionId;
  String? filename;
  String? originalFilename;
  String? url;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
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

class Text {
  Text({
    this.id,
    this.promotionId,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? promotionId;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Text.fromJson(Map<String, dynamic> json) => Text(
        id: json["id"],
        promotionId: json["promotion_id"],
        content: json["content"],
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
        "content": content,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
