// To parse this JSON data, do
//
//     final pointsModel = pointsModelFromJson(jsonString);

import 'dart:convert';

PointsModel pointsModelFromJson(String str) =>
    PointsModel.fromJson(json.decode(str));

String pointsModelToJson(PointsModel data) => json.encode(data.toJson());

class PointsModel {
  PointsModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory PointsModel.fromJson(Map<String, dynamic> json) => PointsModel(
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
    this.total,
  });

  Points? points;
  num? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        points: json["points"] == null ? null : Points.fromJson(json["points"]),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "points": points?.toJson(),
        "total": total,
      };
}

class Points {
  Points({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<PointsData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Points.fromJson(Map<String, dynamic> json) => Points(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<PointsData>.from(json["data"]!.map((x) => PointsData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class PointsData {
  PointsData({
    this.id,
    this.userId,
    this.grandTotal,
    this.points,
    this.operation,
    this.createdAt,
    this.updatedAt,
    this.description,
  });

  int? id;
  int? userId;
  num? grandTotal;
  num? points;
  num? operation;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? description;

  factory PointsData.fromJson(Map<String, dynamic> json) => PointsData(
        id: json["id"],
        userId: json["user_id"],
        grandTotal: json["grand_total"],
        points: json["points"],
        operation: json["operation"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "grand_total": grandTotal,
        "points": points,
        "operation": operation,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "description": description,
      };
}
