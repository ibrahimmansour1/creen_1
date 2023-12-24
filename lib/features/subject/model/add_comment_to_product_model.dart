// To parse this JSON data, do
//
//     final addCommentToProductModel = addCommentToProductModelFromJson(jsonString);

import 'dart:convert';

AddCommentToProductModel addCommentToProductModelFromJson(String str) =>
    AddCommentToProductModel.fromJson(json.decode(str));

String addCommentToProductModelToJson(AddCommentToProductModel data) =>
    json.encode(data.toJson());

class AddCommentToProductModel {
  AddCommentToProductModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory AddCommentToProductModel.fromJson(Map<String, dynamic> json) =>
      AddCommentToProductModel(
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
    this.userId,
    this.productId,
    this.comment,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  int? userId;
  String? productId;
  String? comment;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        productId: json["product_id"],
        comment: json["comment"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "product_id": productId,
        "comment": comment,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
