// To parse this JSON data, do
//
//     final createAdsModel = createAdsModelFromJson(jsonString);

import 'dart:convert';

import 'package:creen/features/ads/model/ad_data.dart';

CreateAdsModel createAdsModelFromJson(String str) => CreateAdsModel.fromJson(json.decode(str));

String createAdsModelToJson(CreateAdsModel data) => json.encode(data.toJson());

class CreateAdsModel {
    CreateAdsModel({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    AdData? data;

    factory CreateAdsModel.fromJson(Map<String, dynamic> json) => CreateAdsModel(
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