// To parse this JSON data, do
//
//     final createStepsModel = createStepsModelFromJson(jsonString);

import 'dart:convert';

import 'step_data.dart';

CreateStepsModel createStepsModelFromJson(String str) => CreateStepsModel.fromJson(json.decode(str));

String createStepsModelToJson(CreateStepsModel data) => json.encode(data.toJson());

class CreateStepsModel {
    bool? status;
    String? message;
    StepData? data;

    CreateStepsModel({
        this.status,
        this.message,
        this.data,
    });

    factory CreateStepsModel.fromJson(Map<String, dynamic> json) => CreateStepsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : StepData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}