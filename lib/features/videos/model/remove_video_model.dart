
import 'dart:convert';

import 'package:creen/features/videos/model/videos_model.dart';

removeVideoModel removeVideoModelFromJson(String str) => removeVideoModel.fromJson(json.decode(str));

String removeVideoModelToJson(removeVideoModel data) => json.encode(data.toJson());

class removeVideoModel {
  removeVideoModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  VideoData? data;

  factory removeVideoModel.fromJson(Map<String, dynamic> json) => removeVideoModel(
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