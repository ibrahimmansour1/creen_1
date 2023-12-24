// To parse this JSON data, do
//
//     final createReportModel = createReportModelFromJson(jsonString);

import 'dart:convert';

CreateReportModel createReportModelFromJson(String str) => CreateReportModel.fromJson(json.decode(str));

String createReportModelToJson(CreateReportModel data) => json.encode(data.toJson());

class CreateReportModel {
    CreateReportModel({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    Data? data;

    factory CreateReportModel.fromJson(Map<String, dynamic> json) => CreateReportModel(
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
    Data({
        this.userId,
        this.modelType,
        this.modelId,
        this.message,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    int? userId;
    String? modelType;
    String? modelId;
    String? message;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        modelType: json["model_type"],
        modelId: json["model_id"],
        message: json["message"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "model_type": modelType,
        "model_id": modelId,
        "message": message,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
