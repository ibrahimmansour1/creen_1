// To parse this JSON data, do
//
//     final deleteBlogModel = deleteBlogModelFromJson(jsonString);

import 'dart:convert';

DeleteBlogModel deleteBlogModelFromJson(String str) => DeleteBlogModel.fromJson(json.decode(str));

String deleteBlogModelToJson(DeleteBlogModel data) => json.encode(data.toJson());

class DeleteBlogModel {
    DeleteBlogModel({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    String? data;

    factory DeleteBlogModel.fromJson(Map<String, dynamic> json) => DeleteBlogModel(
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
