// To parse this JSON data, do
//
//     final addVideoModel = addVideoModelFromJson(jsonString);

import 'dart:convert';

import 'package:creen/features/videos/model/videos_model.dart';

AddVideoModel addVideoModelFromJson(String str) => AddVideoModel.fromJson(json.decode(str));

String addVideoModelToJson(AddVideoModel data) => json.encode(data.toJson());

class AddVideoModel {
    AddVideoModel({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    VideoData? data;

    factory AddVideoModel.fromJson(Map<String, dynamic> json) => AddVideoModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : VideoData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}