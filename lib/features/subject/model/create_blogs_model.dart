// To parse this JSON data, do
//
//     final createBlogModel = createBlogModelFromJson(jsonString);

import 'dart:convert';

import 'blogs_model.dart';

CreateBlogModel createBlogModelFromJson(String str) =>
    CreateBlogModel.fromJson(json.decode(str));

String createBlogModelToJson(CreateBlogModel data) =>
    json.encode(data.toJson());

class CreateBlogModel {
  CreateBlogModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  // String? message;
  Map<String, dynamic>? message;
  Blogs? data;

  factory CreateBlogModel.fromJson(Map<String, dynamic> json) {
    // print("runtime ${json["message"].runtimeType}");
    return CreateBlogModel(
        status: json["status"],
        message: json["message"].runtimeType == String?{"message":"success"}:json["message"],
        data: json["data"] == null ? null : Blogs.fromJson(json["data"]),
      );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

