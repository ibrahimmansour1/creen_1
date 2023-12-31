// To parse this JSON data, do
//
//     final myAdsModel = myAdsModelFromJson(jsonString);

import 'dart:convert';

import 'ad_data.dart';

ViewPromotionsModel myAdsModelFromJson(String str) =>
    ViewPromotionsModel.fromJson(json.decode(str));

String myAdsModelToJson(ViewPromotionsModel data) => json.encode(data.toJson());

class ViewPromotionsModel {
  ViewPromotionsModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  AdData? data;

  factory ViewPromotionsModel.fromJson(Map<String, dynamic> json) => ViewPromotionsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : AdData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}
