// To parse this JSON data, do
//
//     final createProductModel = createProductModelFromJson(jsonString);

import 'dart:convert';

import 'product_data_model.dart';

CreateProductModel createProductModelFromJson(String str) => CreateProductModel.fromJson(json.decode(str));

String createProductModelToJson(CreateProductModel data) => json.encode(data.toJson());

class CreateProductModel {
    bool? status;
    String? message;
    ProductDetailsData? data;

    CreateProductModel({
        this.status,
        this.message,
        this.data,
    });

    factory CreateProductModel.fromJson(Map<String, dynamic> json) => CreateProductModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : ProductDetailsData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}
