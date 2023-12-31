// To parse this JSON data, do
//
//     final likeBlogModel = likeBlogModelFromJson(jsonString);

import 'dart:convert';

LikeBlogModel likeBlogModelFromJson(String str) =>
    LikeBlogModel.fromJson(json.decode(str));

String likeBlogModelToJson(LikeBlogModel data) => json.encode(data.toJson());

class LikeBlogModel {
  LikeBlogModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  int? data;

  factory LikeBlogModel.fromJson(Map<String, dynamic> json) => LikeBlogModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
