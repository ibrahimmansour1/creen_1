// To parse this JSON data, do
//
//     final stepsModel = stepsModelFromJson(jsonString);

import 'dart:convert';

import 'step_data.dart';

StepsModel stepsModelFromJson(String str) => StepsModel.fromJson(json.decode(str));

String stepsModelToJson(StepsModel data) => json.encode(data.toJson());

class StepsModel {
    bool? status;
    String? message;
    Data? data;

    StepsModel({
        this.status,
        this.message,
        this.data,
    });

    factory StepsModel.fromJson(Map<String, dynamic> json) => StepsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    StepData? todaySteps;
    List<StepData>? totalSteps;

    Data({
        this.todaySteps,
        this.totalSteps,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        todaySteps: json["todaySteps"] == null ? null : StepData.fromJson(json["todaySteps"]),
        totalSteps: json["totalSteps"] == null ? [] : List<StepData>.from(json["totalSteps"]!.map((x) => StepData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "todaySteps": todaySteps?.toJson(),
        "totalSteps": totalSteps == null ? [] : List<dynamic>.from(totalSteps!.map((x) => x.toJson())),
    };
}

