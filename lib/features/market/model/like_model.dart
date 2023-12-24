// To parse this JSON data, do
//
//     final reactionModel = reactionModelFromJson(jsonString);

import 'dart:convert';

ReactionModel reactionModelFromJson(String str) =>
    ReactionModel.fromJson(json.decode(str));

String reactionModelToJson(ReactionModel data) => json.encode(data.toJson());

class ReactionModel {
  ReactionModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  dynamic data;

  factory ReactionModel.fromJson(Map<String, dynamic> json) => ReactionModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.userId,
    this.productId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  int? userId;
  String? productId;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        productId: json["product_id"],
        updatedAt: DateTime.tryParse(json["updated_at"] ?? ''),
        createdAt: DateTime.tryParse(json["created_at"] ?? ''),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "product_id": productId,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
