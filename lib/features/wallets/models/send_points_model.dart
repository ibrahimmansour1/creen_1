// To parse this JSON data, do
//
//     final transferPointsModel = transferPointsModelFromJson(jsonString);

import 'dart:convert';

TransferPointsModel transferPointsModelFromJson(String str) => TransferPointsModel.fromJson(json.decode(str));

String transferPointsModelToJson(TransferPointsModel data) => json.encode(data.toJson());

class TransferPointsModel {
    TransferPointsModel({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    Data? data;

    factory TransferPointsModel.fromJson(Map<String, dynamic> json) => TransferPointsModel(
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
        this.points,
    });

    Points? points;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        points: json["points"] == null ? null : Points.fromJson(json["points"]),
    );

    Map<String, dynamic> toJson() => {
        "points": points?.toJson(),
    };
}

class Points {
    Points({
        this.userId,
        this.grandTotal,
        this.points,
        this.operation,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.description,
    });

    int? userId;
    int? grandTotal;
    String? points;
    int? operation;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;
    String? description;

    factory Points.fromJson(Map<String, dynamic> json) => Points(
        userId: json["user_id"],
        grandTotal: json["grand_total"],
        points: json["points"],
        operation: json["operation"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "grand_total": grandTotal,
        "points": points,
        "operation": operation,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "description": description,
    };
}
