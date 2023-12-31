// To parse this JSON data, do
//
//     final createNewStoryModel = createNewStoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:creen/features/chat/model/story_data.dart';

CreateNewStoryModel createNewStoryModelFromJson(String str) =>
    CreateNewStoryModel.fromJson(json.decode(str));

String createNewStoryModelToJson(CreateNewStoryModel data) =>
    json.encode(data.toJson());

class CreateNewStoryModel {
  CreateNewStoryModel({
    required this.status,
    required this.message,
    this.data,
  });

  bool status;
  String message;
  StoryData? data;

  factory CreateNewStoryModel.fromJson(Map<String, dynamic> json) =>
      CreateNewStoryModel(
        status: json["status"] ?? false,
        message: json["message"] ?? '',
        data: json["data"] == null ? null : StoryData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}
